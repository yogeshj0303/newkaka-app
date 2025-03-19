import 'package:kake_autoparts/Constants/exports.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/currentUser.dart';

class GetController extends GetxController {
  //Bottom Nav Bar Index
  RxInt currIndex = 0.obs;
  RxInt notificationCount = 0.obs;
  //Login with OTP
  RxBool isAuthLoading = false.obs;
  RxInt otp = 0000.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool showPassword = true.obs;
  //autologin
  RxString authPhone = ''.obs;
  //Register
  RxBool isRegLoading = false.obs;

  //Register User Data
  RxString name = ''.obs;
  RxString city = ''.obs;
  RxString phone = ''.obs;
  // var currentUser = currentUser().obs;


  //products
  RxBool isProLikeLoading = false.obs;
  RxBool isProductLiked = false.obs;
  RxBool isProductInCart = false.obs;
  RxBool isCartLoading = false.obs;
  RxInt dealId = 0.obs;
  //address
  RxBool isAddressLoading = false.obs;
  RxInt defaultAddressId = 0.obs;
  //cart
  RxInt cartTotal = 0.obs;
  RxInt discount = 0.obs;
  RxInt amountPayable = 0.obs;
  RxString qty = '1'.obs;
  RxInt cartId = 0.obs;
  //language
  RxString lang = 'en'.obs;
  RxBool login_status = false.obs;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    Locale locale1 = const Locale('hi', 'IN');
    Locale locale2 = const Locale('en', 'US');
    Locale locale3 = const Locale('mr', 'IN');
    Locale locale4 = const Locale('gu', 'IN');
    Locale locale5 = const Locale('ta', 'IN');
    lang.value == 'hi'
        ? Get.updateLocale(locale1)
        : lang.value == 'en'
        ? Get.updateLocale(locale2)
        : lang.value == 'mr'
        ? Get.updateLocale(locale3)
        : lang.value == 'gu'
        ? Get.updateLocale(locale4)
        : Get.updateLocale(locale5);
    name.value = GlobalVariable.name;
    city.value = GlobalVariable.city;
    phone.value = GlobalVariable.phone;
    login_status.value = GlobalVariable.login_status;
  }
}
