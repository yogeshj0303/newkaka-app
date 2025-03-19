import 'dart:convert';
import 'package:kake_autoparts/Constants/exports.dart';
import '../Models/addressmodel.dart';
import 'package:http/http.dart' as http;

class ProfileUtils {
  static final c = Get.put(GetController());
  static Future<void> addAddress(
      String street, String city, String state, String pin) async {
    c.isAddressLoading.value = true;
    final url =
        '${apiUrl}addaddress?customer_id=${GlobalVariable.id}&street=$street&city=$city&country=India&state=$state&pin_code=$pin';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Address added'.tr);
        c.isAddressLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isAddressLoading.value = false;
      }
    } else {
      Get.back();
      c.isAddressLoading.value = false;
    }
    throw Exception('Unable to load data');
  }

  static Future<void> deleteAddress(int addressId) async {
    c.isAddressLoading.value = true;
    final url =
        '${apiUrl}deleteaddress?customer_id=${GlobalVariable.id}&address_id=$addressId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Address deleted'.tr);
        c.isAddressLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isAddressLoading.value = false;
      }
    } else {
      c.isAddressLoading.value = false;
    }
    throw Exception('Unable to load data');
  }

  static Future<AddressModel> getAddress() async {
    final url = '${apiUrl}showaddress?customer_id=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return AddressModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    }
    throw Exception('Unable to load data');
  }
}
