import '../Constants/exports.dart';

class SharedPrefs {
  static final c = Get.put(GetController());

  static Future<void> loginSave(
      String phone, String lang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('phone', phone);
    preferences.setString('lang', lang);
  }

  static Future<bool> autoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('phone')) {
      print('Auto Login ${preferences.getString('phone')}, ${preferences.getString('lang')}');
      String phone = preferences.getString('phone')!;
      String language = preferences.getString('lang')!;
      c.phone.value = phone;
      c.lang.value = language;
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    c.currIndex.value = 0;
    Get.offAll(() => const LoginScreen(),
        transition: Transition.leftToRightWithFade,
    );
  }
}
