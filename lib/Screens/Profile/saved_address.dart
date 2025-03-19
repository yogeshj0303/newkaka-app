import 'package:kake_autoparts/Models/addressmodel.dart';
import 'package:kake_autoparts/Utils/whatsapp_utils.dart';
import '../../Constants/exports.dart';
import '../../Models/cartitems.dart';

class SavedAddress extends StatefulWidget {
  final bool forOrder;
  final bool forWhatsappOrder;
  final List<CartData>? cartItems;
  const SavedAddress(
      {super.key,
      required this.forOrder,
      required this.forWhatsappOrder,
      this.cartItems});

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  final c = Get.put(GetController());
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final pin = TextEditingController();
  final addKey = GlobalKey<FormState>();
  final _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ProductUtils.placeOrder(c.defaultAddressId.value, c.cartId.value, 'Online');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: response.walletName.toString());
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: widget.forOrder
            ? Text('Select Address'.tr)
            : Text('Saved Addresses'.tr),
      ),
      body: Obx(
        () => c.isAddressLoading.value
            ? loading
            : FutureBuilder<AddressModel>(
                future: ProfileUtils.getAddress(),
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data!.data!.isEmpty
                        ? Center(
                            child: widget.forOrder
                                ? Text('Please add address to proceed further'.tr,
                                    style: normalLightText)
                                : Text('No Address saved yet'.tr,
                                    style: normalLightText))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) => widget.forOrder
                                ? buildAddressCard1(snapshot, index)
                                : buildAddressCard(snapshot, index))
                    : loading),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addAddressDialog(),
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: whiteColor),
      ),
    );
  }

  Widget buildAddressCard(AsyncSnapshot<AddressModel> snapshot, int index) {
    final item = snapshot.data!.data![index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: RoundedContainer(
        isImage: false,
        color: whiteColor,
        padding: const EdgeInsets.all(defaultPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.city}', style: normalText),
            const SizedBox(height: 5),
            Text('${item.street!}, ${item.city}', style: normalLightText),
            Text('${item.state!}, ${item.country}', style: normalLightText),
            Text(item.pinCode!, style: normalLightText),
            const SizedBox(height: 5),
            Text(c.phone.value, style: smallText),
            const SizedBox(height: 5),
            const Divider(color: Colors.black12),
            TextButton(
                onPressed: () => ProfileUtils.deleteAddress(item.id!.toInt()),
                child: Text(
                  'Delete'.tr,
                  style: const TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildAddressCard1(AsyncSnapshot<AddressModel> snapshot, int index) {
    final item = snapshot.data!.data![index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: RoundedContainer(
        onTap: () {
          c.defaultAddressId.value = item.id!.toInt();
          if (widget.forWhatsappOrder) {
            WhatsAppShare.sendDataToWhatsApp(widget.cartItems!, item);
          } else {
            // Handle other cases, e.g., opening Razorpay for payment
          }
        },
        isImage: false,
        color: whiteColor,
        padding: const EdgeInsets.all(defaultPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(c.name.value, style: normalText),
            const SizedBox(height: 5),
            Text('${item.street!}, ${item.city}', style: normalLightText),
            Text('${item.state!}, ${item.country}', style: normalLightText),
            Text(item.pinCode!, style: normalLightText),
            const SizedBox(height: 5),
            Text(c.phone.value, style: smallText),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
  addAddressDialog() {
    street.clear();
    city.clear();
    state.clear();
    pin.clear();
    return Get.defaultDialog(
        title: 'Add Address'.tr,
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: addKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: street,
                  hintText: 'Street'.tr,
                  iconData: Icons.house,
                ),
                CustomTextField(
                  controller: city,
                  hintText: 'City'.tr,
                  iconData: Icons.location_city,
                ),
                CustomTextField(
                  controller: state,
                  hintText: 'State'.tr,
                  iconData: Icons.real_estate_agent,
                ),
                CustomTextField(
                  controller: pin,
                  hintText: 'Pin code'.tr,
                  iconData: Icons.pin_drop,
                ),
                const SizedBox(height: 8),
                myButton(
                    onPressed: () {
                      final isValid = addKey.currentState!.validate();
                      if (isValid) {
                        Get.back();
                        ProfileUtils.addAddress(
                            street.text, city.text, state.text, pin.text);
                      }
                    },
                    label: 'Add'.tr,
                    color: primaryColor,
                    style: normalWhiteText)
              ],
            ),
          ),
        ));
  }
}
