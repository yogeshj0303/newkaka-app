import '../Constants/exports.dart';
import '../Models/addressmodel.dart';
import '../Models/cartitems.dart';

class WhatsAppShare {
  static final c = Get.put(GetController());
  static void sendImageToWhatsApp(
      String phone, String imgUrl, String msg) async {
    final String phoneNumber = phone;
    final String message = msg;
    final String imageUrl = imgUrl;
    final String encodedMessage = Uri.encodeComponent('$message\n$imageUrl');
    final whatsappUrl =
        'whatsapp://send?phone=$phoneNumber&text=$encodedMessage';
    await launchUrl(Uri.parse(whatsappUrl));
  }

  static void sendImagesToWhatsApp(
      String phone, List<String> imageUrls, String msg) async {
    final String phoneNumber = phone;
    final String message = msg;
    final StringBuffer encodedMessage =
        StringBuffer(Uri.encodeComponent('$message\n'));
    for (String imageUrl in imageUrls) {
      encodedMessage.write(Uri.encodeComponent('$imageUrl\n'));
    }
    final whatsappUrl =
        'whatsapp://send?phone=$phoneNumber&text=${encodedMessage.toString()}';
    await launchUrl(Uri.parse(whatsappUrl));
  }

  static void sendDataToWhatsApp(List<CartData> cartItems , Data address) async {
    const String phoneNumber = '9893248155';
    final String addressString =
        '${address.street}, ${address.city}, ${address.state}, ${address.pinCode}, ${address.country}';
    final String message =
        '${c.name.value}\n${c.phone.value}\n${addressString},\nOrder Details for value ${c.amountPayable.value}';
    final StringBuffer encodedMessage =
        StringBuffer(Uri.encodeComponent('$message\n'));
    for (CartData cartItem in cartItems) {
      encodedMessage.write(Uri.encodeComponent(
          'Image : ${cartItem.image}\nProduct Name : ${cartItem.itemName}\nCost: ${cartItem.cost}\nQuantity : ${cartItem.qt}\n\n'));
    }
    final whatsappUrl =
        'whatsapp://send?phone=$phoneNumber&text=${encodedMessage.toString()}';
    await launchUrl(Uri.parse(whatsappUrl));
    ProductUtils.placeOrder(
        c.defaultAddressId.value, c.cartId.value, 'Through WhatsApp');
  }
}

  // static void sendDataToWhatsApp(List<CartData> cartItems, String msg) async {
  //   const String phoneNumber = '9893248155';
  //   String encodedMessage = '';
  //   for (var cartItem in cartItems) {
  //     encodedMessage += 'Image : ${cartItem.image}, Product Name : ${cartItem.itemName}, Cost : ${cartItem.cost}, Quantity : ${cartItem.qt}';
  //   }
  //   final whatsappUrl =
  //       'whatsapp://send?phone=$phoneNumber&text=${encodedMessage.toString()}';
  //   await launchUrl(Uri.parse(whatsappUrl));
  // }
