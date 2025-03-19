import 'dart:convert';
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:http/http.dart' as http;
import 'package:kake_autoparts/Models/noti_model.dart';
import '../Models/cartmodel.dart';
import '../Models/show_ordermodel.dart';
import '../Models/wishlistmodel.dart';

class ProductUtils {
  static final c = Get.put(GetController());
  static Future<void> addToWishlist(int subCatgId) async {
    final url =
        '${apiUrl}addtowishlist?customer_id=${GlobalVariable.id}&subcategorie_id=$subCatgId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        c.isProductLiked.value = true;
        Fluttertoast.showToast(msg: 'Item saved in your Wishlist'.tr);
      } else {
        Fluttertoast.showToast(msg: 'item already exits in wishlist');
      }
    } else {
      c.isProLikeLoading.value = false;
    }
  }

  static Future<WishListModel> showWishlist() async {
    final url = '${apiUrl}getWishlist?customer_id=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return WishListModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    }
    throw Exception('Unable to laod data');
  }

  static Future<void> addToCart(int subCatgId) async {
    c.isProLikeLoading.value = true;
    final url =
        '${apiUrl}addtocart?customerid=${GlobalVariable.id}&subcategorieid=$subCatgId&quantity=1';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      c.isProLikeLoading.value = false;
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        c.isProductInCart.value = true;
        Fluttertoast.showToast(msg: 'Item added to cart'.tr);
      } else {
        Fluttertoast.showToast(msg: 'item already exits in cart');
      }
    } else {
      c.isProLikeLoading.value = false;
    }
  }

  static Future<CartModel> showCart() async {
    final url = '${apiUrl}getCart?customerid=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return CartModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong...');
      }
    }
    throw Exception('Unable to load data');
  }

  static Future<void> placeOrder(
      int addressID, int cartID, String payMethod) async {
    final url =
        '${apiUrl}purchaseorder?customerid=${GlobalVariable.id}&address_id=$addressID&cart_id=$cartID&payment_method=$payMethod';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      c.isCartLoading.value = false;
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Order has been successfully placed'.tr);
        Get.back();
      } else {
        Fluttertoast.showToast(msg: 'No items in cart');
      }
    } else {
      Get.back();
    }
  }

  static Future<ShowOrderModel> showOrders() async {
    final url = '${apiUrl}getOrderData?customerid=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return ShowOrderModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong...');
      }
    }
    throw Exception('Unable to load data');
  }

  static Future<NotificationModel> showNotification() async {
    final url = '${apiUrl}notifications?customerid=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return NotificationModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong...');
      }
    }
    throw Exception('Unable to load data');
  }

  Future<void> fetchNotificationCount() async {
    final url = '${apiUrl}notifications?customerid=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        c.notificationCount.value = data['Notification_count'];
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong...');
      }
    }
  }
}
