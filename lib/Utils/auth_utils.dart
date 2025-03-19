import 'dart:convert';
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:http/http.dart' as http;
import 'package:kake_autoparts/Screens/Orders/Home/main_screen.dart';


class AuthUtils {
  static final c = Get.put(GetController());
  static Future<void> getOtp(String phone) async {
    c.isAuthLoading.value = true;
    final url = '${apiUrl}send_otp?phone=$phone';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        c.otp.value = data['otp'];
        c.isAuthLoading.value = false;
        Get.off(() => OtpScreen(number: phone));
      } else {
        c.isAuthLoading.value = false;
        Fluttertoast.showToast(msg: 'Please Enter your mobile number');
      }
    } else {
      c.isAuthLoading.value = false;
      Fluttertoast.showToast(
          msg: 'Internal Server Error with code : ${response.statusCode}');
    }
  }


  static Future<void> getRegistered({
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      final url = '${apiUrl}customer_data?name=$name&phone=$phone&city=$city';
      c.isRegLoading.value = true;

      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          SharedPrefs.loginSave(phone, c.lang.value);
          GlobalVariable.id = data['data']['id'];
          GlobalVariable.name = data['data']['name'];
          GlobalVariable.phone = data['data']['phone'];
          GlobalVariable.city = data['data']['city'];

          Get.offAll(() => const MainScreen());
        } else {
          Fluttertoast.showToast(msg: data['message'] ?? 'An error occurred');
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Internal Server Error with code: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e');
    } finally {
      c.isRegLoading.value = false;
    }
  }

  static Future<void> authCheck(String phone) async {
    c.isRegLoading.value = true;
    final url = '${apiUrl}login_check?phone=$phone';

    try {
      final response = await http.post(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        print('Parsed response data: $data');

        if (data['error'] == false) {
          SharedPrefs.loginSave(phone, c.lang.value);
          GlobalVariable.id = data['data']['id'];
          GlobalVariable.name = data['data']['name'];
          GlobalVariable.phone = data['data']['phone'];
          GlobalVariable.city = data['data']['city'];

          c.isRegLoading.value = false;
          Get.offAll(() => const MainScreen());
        } else {
          c.isRegLoading.value = false;
          Get.off(() => const UserData());
        }
      } else {
        Fluttertoast.showToast(msg: 'Internal Server Error');
        c.isRegLoading.value = false;
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: 'An error occurred');
      c.isRegLoading.value = false;
    }
  }
}
