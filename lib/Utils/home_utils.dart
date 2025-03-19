import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kake_autoparts/Constants/exports.dart';
import '../Models/banner_model.dart';
import '../Models/category_model.dart';
import '../Models/sub_cat_model.dart';

class HomeUtils {
  static final c = Get.put(GetController());
  static Future<BannerModel> getBanner() async {
    final url = '${apiUrl}banners';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());

        if (data['error'] == false) {
          return BannerModel.fromJson(data);
        } else {
          throw Exception('Error: Banner not loaded');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching banner: $e');
      Fluttertoast.showToast(msg: 'Unable to load data');
      throw Exception('Unable to load data');
    }
  }

  static Future<CategoryModel> getCategory() async {
    const url = '${apiUrl}categorie';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        if (data['error'] == false) {
          return CategoryModel.fromJson(data);
        } else {
          Fluttertoast.showToast(msg: 'Banner not loaded');
          throw Exception('Error: Banner not loaded');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching category: $e');
      throw Exception('Unable to load data');
    }
  }
  static Future<SubCategoryModel> getSubCategory(int catId) async {
    final url =
        '${apiUrl}subcategorie?category_id=$catId&customer_id=${GlobalVariable.id}';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        print('Response data: $data');
        print('Category ID: $catId');
        print('Customer ID: ${GlobalVariable.id}');

        if (data['error'] == false) {
          return SubCategoryModel.fromJson(data);
        } else {
          Fluttertoast.showToast(msg: 'Product not loaded');
          throw Exception('Error: Product not loaded');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching subcategory: $e');
      throw Exception('Unable to load data');
    }
  }
  static Future<SubCategoryModel> getSearch(String keyWords) async {
    final url = '${apiUrl}search?subcategory=$keyWords';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        print('Response data: $data');

        if (data['error'] == false) {
          return SubCategoryModel.fromJson(data);
        } else {
          Fluttertoast.showToast(msg: 'Product not loaded');
          throw Exception('Error: Product not loaded');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching: $e');
      throw Exception('Unable to load data');
    }
  }

  static Future<SubCategoryModel> getDealofDay() async {
    final url = '${apiUrl}AllDealProduct?customer_id=${GlobalVariable.id}';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        print("Deal of the day response: $data");

        if (data['error'] == false) {
          print("Error status: ${data['error']}");
          return SubCategoryModel.fromJson(data);
        } else {
          Fluttertoast.showToast(msg: 'Product not loaded');
          throw Exception('Error: Product not loaded');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching deal of the day: $e');
      throw Exception('Unable to load data');
    }
  }
}
