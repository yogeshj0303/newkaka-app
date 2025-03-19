import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Models/cartitems.dart';
import 'package:kake_autoparts/Models/cartmodel.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final c = Get.put(GetController());
  final qtyController = TextEditingController();
  String qty = '';
  List<int> qtyList = List.generate(500, (index) => 1 + index);
  Future<void> removeFromCart(int subCatgId) async {
    final url =
        '${apiUrl}deleteCart?customerid=${GlobalVariable.id}&subcategorieid=$subCatgId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Item removed from cart'.tr)
            .then((value) => setState(() {}));
      } else {
        Fluttertoast.showToast(msg: 'Item not found'.tr);
      }
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  Future<void> updateQuantity(int subCatgId, String quantity) async {
    final url =
        '${apiUrl}updateCart?customerid=${GlobalVariable.id}&subcategorieid=$subCatgId&quantity=$quantity';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Item quantity updated'.tr)
            .then((value) => setState(() {}));
      } else {
        Fluttertoast.showToast(msg: 'error true');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<CartModel>(
          future: ProductUtils.showCart(),
          builder: (context, snapshot) => snapshot.hasData
              ? snapshot.data!.data!.cartItems!.isEmpty
                  ? noProduct(size)
                  : Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: SizedBox(
                            height: size.height * 0.65,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data!.cartItems!.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: defaultPadding),
                                child: RoundedContainer(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  isImage: false,
                                  color: whiteColor,
                                  child: Row(
                                    children: [
                                      RoundedContainer(
                                        height: 150,
                                        width: size.width * 0.3,
                                        isImage: true,
                                        networkImg:
                                            '$imgPath/${snapshot.data!.data!.cartItems![index].subcategoriesDetails!.image}',
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width / 2,
                                            child: c.lang.value == 'en'
                                                ? Text(
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .cartItems![index]
                                                        .subcategoriesDetails!
                                                        .subcategory!
                                                        .toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : c.lang.value == 'hi'
                                                    ? TranslateHelper(
                                                        data: snapshot
                                                            .data!
                                                            .data!
                                                            .cartItems![index]
                                                            .subcategoriesDetails!
                                                            .subcategory!
                                                            .toUpperCase(),
                                                        language: 'hi',
                                                      )
                                                    : c.lang.value == 'mr'
                                                        ? TranslateHelper(
                                                            data: snapshot
                                                                .data!
                                                                .data!
                                                                .cartItems![
                                                                    index]
                                                                .subcategoriesDetails!
                                                                .subcategory!
                                                                .toUpperCase(),
                                                            language: 'mr')
                                                        : c.lang.value == 'gu'
                                                            ? TranslateHelper(
                                                                data: snapshot
                                                                    .data!
                                                                    .data!
                                                                    .cartItems![
                                                                        index]
                                                                    .subcategoriesDetails!
                                                                    .subcategory!
                                                                    .toUpperCase(),
                                                                language: 'gu')
                                                            : TranslateHelper(
                                                                data: snapshot
                                                                    .data!
                                                                    .data!
                                                                    .cartItems![
                                                                        index]
                                                                    .subcategoriesDetails!
                                                                    .subcategory!
                                                                    .toUpperCase(),
                                                                language: 'ta'),
                                          ),
                                          Row(
                                            children: [
                                              Text('₹', style: normalText),
                                              Text(
                                                snapshot
                                                    .data!
                                                    .data!
                                                    .cartItems![index]
                                                    .subcategoriesDetails!
                                                    .total!,
                                                style: normalText,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '₹${snapshot.data!.data!.cartItems![index].subcategoriesDetails!.price!}'
                                                    .toString(),
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.black45),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                  '₹${snapshot.data!.data!.cartItems![index].subcategoriesDetails!.discountedPrice!} Off',
                                                  style: smallColorText)
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          SizedBox(
                                            width: size.width / 2 - 12,
                                            child: c.lang.value == 'en'
                                                ? Text(
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .cartItems![index]
                                                        .subcategoriesDetails!
                                                        .description!,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : c.lang.value == 'hi'
                                                    ? TranslateHelper(
                                                        data: snapshot
                                                            .data!
                                                            .data!
                                                            .cartItems![index]
                                                            .subcategoriesDetails!
                                                            .description!,
                                                        language: 'hi',
                                                      )
                                                    : c.lang.value == 'mr'
                                                        ? TranslateHelper(
                                                            data: snapshot
                                                                .data!
                                                                .data!
                                                                .cartItems![
                                                                    index]
                                                                .subcategoriesDetails!
                                                                .description!,
                                                            language: 'mr')
                                                        : c.lang.value == 'gu'
                                                            ? TranslateHelper(
                                                                data: snapshot
                                                                    .data!
                                                                    .data!
                                                                    .cartItems![
                                                                        index]
                                                                    .subcategoriesDetails!
                                                                    .description!,
                                                                language: 'gu')
                                                            : TranslateHelper(
                                                                data: snapshot
                                                                    .data!
                                                                    .data!
                                                                    .cartItems![
                                                                        index]
                                                                    .subcategoriesDetails!
                                                                    .description!,
                                                                language: 'ta'),
                                          ),
                                          Row(
                                            children: [
                                              RoundedContainer(
                                                onTap: () {},
                                                isImage: false,
                                                color: bgColor,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal:
                                                            defaultPadding),
                                                child: Row(
                                                  children: [
                                                    Text('Quantity'.tr,
                                                        style: xsmallText),
                                                    const SizedBox(width: 4),
                                                    SizedBox(
                                                      width: 45,
                                                      child:
                                                          DropdownButtonFormField<
                                                              int>(
                                                        style: xsmallText,
                                                        value: int.parse(
                                                            snapshot
                                                                .data!
                                                                .data!
                                                                .cartItems![
                                                                    index]
                                                                .quantity!),
                                                        items: qtyList
                                                            .map((e) =>
                                                                DropdownMenuItem<
                                                                        int>(
                                                                    value: e,
                                                                    child: Text(
                                                                        e.toString())))
                                                            .toList(),
                                                        onChanged: (value) =>
                                                            updateQuantity(
                                                                snapshot
                                                                    .data!
                                                                    .data!
                                                                    .cartItems![
                                                                        index]
                                                                    .subcategoriesDetails!
                                                                    .id!
                                                                    .toInt(),
                                                                value
                                                                    .toString()),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 24),
                                              InkWell(
                                                onTap: () => removeFromCart(
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .cartItems![index]
                                                        .subcategoriesDetails!
                                                        .id!
                                                        .toInt()),
                                                child: Text('Remove'.tr,
                                                    style: xSmallColorText),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: buildPaymentCard(snapshot),
                        ),
                      ],
                    )
              : loading),
    );
  }

  Container buildPaymentCard(AsyncSnapshot<CartModel> snapshot) {
    c.cartTotal.value = snapshot.data!.data!.productPrice!.toInt();
    c.discount.value = snapshot.data!.data!.productDiscount!.toInt();
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Order Details'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cart Total'.tr, style: normalLightText),
              Text(
                '₹${c.cartTotal.value}.00',
                style: normalText,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cart Savings'.tr, style: normalLightText),
              Text(
                '-₹${(c.discount.value)}.00',
                style: normalColorText,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount Payable'.tr,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                '₹${c.cartTotal.value - c.discount.value}.00',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  c.amountPayable.value = c.cartTotal.value - c.discount.value;
                  c.cartId.value =
                      snapshot.data!.data!.cartItems![0].id!.toInt();
                  int length = snapshot.data!.data!.cartItems!.length;
                  List<CartData> cartData = [];
                  for (int i = 0; i < length; i++) {
                    cartData.add(
                        CartData(
                        image:
                            '$imgPath/${snapshot.data!.data!.cartItems![i].subcategoriesDetails!.image!}',
                        itemName: snapshot.data!.data!.cartItems![i]
                            .subcategoriesDetails!.subcategory!,
                        cost: snapshot.data!.data!.cartItems![i]
                            .subcategoriesDetails!.total!,
                        qt: snapshot.data!.data!.cartItems![i].quantity!));
                  }
                  Get.to(() => SavedAddress(
                        forOrder: true,
                        forWhatsappOrder: true,
                        cartItems: cartData,
                      ));
                },
                child: MyContainer(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(whatsAppIcon, height: 25),
                      const SizedBox(width: 2),
                      Text('Order on WhatsApp'.tr, style: xSmallColorText),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  c.amountPayable.value = c.cartTotal.value - c.discount.value;
                  c.cartId.value =
                      snapshot.data!.data!.cartItems![0].id!.toInt();
                  Get.to(() => const SavedAddress(
                      forOrder: true, forWhatsappOrder: false));
                },
                child: MyContainer(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag_outlined,
                          color: secondaryColor, size: 25),
                      const SizedBox(width: 2),
                      Text('Proceed to payment'.tr, style: xSmallColorText),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Column noProduct(Size size) {
    return Column(
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.all(defaultPadding),
          child: Lottie.asset(cartLottie, height: 275, fit: BoxFit.cover),
        ),
        const SizedBox(height: 55),
        Text('No Products in your Cart'.tr, style: largeLightText)
      ],
    );
  }

  showQuantityUpdateDialog(int proId, int index) {
    qtyController.text = '';
    return Get.defaultDialog(
      title: 'Select Quantity'.tr,
      content: Column(
        children: [
          MyContainer(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            height: 45,
            width: 65,
            child: TextFormField(
              controller: qtyController,
              onChanged: (value) => qty = value,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Qty',
              ),
            ),
          ),
          const SizedBox(height: 16),
          myButton(
              onPressed: () => qtyController.text.isEmpty
                  ? Fluttertoast.showToast(msg: 'Quantity can not be empty'.tr)
                  : updateQuantity(proId, qty),
              label: 'Update'.tr,
              color: secondaryColor,
              style: smallWhiteText)
        ],
      ),
    );
  }
}
