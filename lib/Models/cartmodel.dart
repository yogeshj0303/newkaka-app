import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    bool? error,
    Data? data,
    String? message,
  }) {
    _error = error;
    _data = data;
    _message = message;
  }

  CartModel.fromJson(dynamic json) {
    _error = json['error'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _error;
  Data? _data;
  String? _message;
  CartModel copyWith({
    bool? error,
    Data? data,
    String? message,
  }) =>
      CartModel(
        error: error ?? _error,
        data: data ?? _data,
        message: message ?? _message,
      );
  bool? get error => _error;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? productCount,
    num? productPrice,
    num? productDiscount,
    num? productTotal,
    List<CartItems>? cartItems,
  }) {
    _productCount = productCount;
    _productPrice = productPrice;
    _productDiscount = productDiscount;
    _productTotal = productTotal;
    _cartItems = cartItems;
  }

  Data.fromJson(dynamic json) {
    _productCount = json['product_count'];
    _productPrice = json['product_price'];
    _productDiscount = json['product_discount'];
    _productTotal = json['product_total'];
    if (json['cart_items'] != null) {
      _cartItems = [];
      json['cart_items'].forEach((v) {
        _cartItems?.add(CartItems.fromJson(v));
      });
    }
  }
  num? _productCount;
  num? _productPrice;
  num? _productDiscount;
  num? _productTotal;
  List<CartItems>? _cartItems;
  Data copyWith({
    num? productCount,
    num? productPrice,
    num? productDiscount,
    num? productTotal,
    List<CartItems>? cartItems,
  }) =>
      Data(
        productCount: productCount ?? _productCount,
        productPrice: productPrice ?? _productPrice,
        productDiscount: productDiscount ?? _productDiscount,
        productTotal: productTotal ?? _productTotal,
        cartItems: cartItems ?? _cartItems,
      );
  num? get productCount => _productCount;
  num? get productPrice => _productPrice;
  num? get productDiscount => _productDiscount;
  num? get productTotal => _productTotal;
  List<CartItems>? get cartItems => _cartItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_count'] = _productCount;
    map['product_price'] = _productPrice;
    map['product_discount'] = _productDiscount;
    map['product_total'] = _productTotal;
    if (_cartItems != null) {
      map['cart_items'] = _cartItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));
String cartItemsToJson(CartItems data) => json.encode(data.toJson());

class CartItems {
  CartItems({
    num? id,
    String? customerid,
    String? subcategorieid,
    String? price,
    String? discount,
    String? total,
    String? quantity,
    String? createdAt,
    String? updatedAt,
    SubcategoriesDetails? subcategoriesDetails,
  }) {
    _id = id;
    _customerid = customerid;
    _subcategorieid = subcategorieid;
    _price = price;
    _discount = discount;
    _total = total;
    _quantity = quantity;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _subcategoriesDetails = subcategoriesDetails;
  }

  CartItems.fromJson(dynamic json) {
    _id = json['id'];
    _customerid = json['customerid'];
    _subcategorieid = json['subcategorieid'];
    _price = json['price'];
    _discount = json['discount'];
    _total = json['total'];
    _quantity = json['quantity'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _subcategoriesDetails = json['subcategories_details'] != null
        ? SubcategoriesDetails.fromJson(json['subcategories_details'])
        : null;
  }
  num? _id;
  String? _customerid;
  String? _subcategorieid;
  String? _price;
  String? _discount;
  String? _total;
  String? _quantity;
  String? _createdAt;
  String? _updatedAt;
  SubcategoriesDetails? _subcategoriesDetails;
  CartItems copyWith({
    num? id,
    String? customerid,
    String? subcategorieid,
    String? price,
    String? discount,
    String? total,
    String? quantity,
    String? createdAt,
    String? updatedAt,
    SubcategoriesDetails? subcategoriesDetails,
  }) =>
      CartItems(
        id: id ?? _id,
        customerid: customerid ?? _customerid,
        subcategorieid: subcategorieid ?? _subcategorieid,
        price: price ?? _price,
        discount: discount ?? _discount,
        total: total ?? _total,
        quantity: quantity ?? _quantity,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        subcategoriesDetails: subcategoriesDetails ?? _subcategoriesDetails,
      );
  num? get id => _id;
  String? get customerid => _customerid;
  String? get subcategorieid => _subcategorieid;
  String? get price => _price;
  String? get discount => _discount;
  String? get total => _total;
  String? get quantity => _quantity;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  SubcategoriesDetails? get subcategoriesDetails => _subcategoriesDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['customerid'] = _customerid;
    map['subcategorieid'] = _subcategorieid;
    map['price'] = _price;
    map['discount'] = _discount;
    map['total'] = _total;
    map['quantity'] = _quantity;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_subcategoriesDetails != null) {
      map['subcategories_details'] = _subcategoriesDetails?.toJson();
    }
    return map;
  }
}

SubcategoriesDetails subcategoriesDetailsFromJson(String str) =>
    SubcategoriesDetails.fromJson(json.decode(str));
String subcategoriesDetailsToJson(SubcategoriesDetails data) =>
    json.encode(data.toJson());

class SubcategoriesDetails {
  SubcategoriesDetails({
    num? id,
    String? categoryId,
    String? subcategory,
    String? image,
    String? price,
    String? discountedPrice,
    String? total,
    String? description,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _categoryId = categoryId;
    _subcategory = subcategory;
    _image = image;
    _price = price;
    _discountedPrice = discountedPrice;
    _total = total;
    _description = description;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  SubcategoriesDetails.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategory = json['subcategory'];
    _image = json['image'];
    _price = json['price'];
    _discountedPrice = json['discounted_price'];
    _total = json['total'];
    _description = json['description'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _categoryId;
  String? _subcategory;
  String? _image;
  String? _price;
  String? _discountedPrice;
  String? _total;
  String? _description;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  SubcategoriesDetails copyWith({
    num? id,
    String? categoryId,
    String? subcategory,
    String? image,
    String? price,
    String? discountedPrice,
    String? total,
    String? description,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      SubcategoriesDetails(
        id: id ?? _id,
        categoryId: categoryId ?? _categoryId,
        subcategory: subcategory ?? _subcategory,
        image: image ?? _image,
        price: price ?? _price,
        discountedPrice: discountedPrice ?? _discountedPrice,
        total: total ?? _total,
        description: description ?? _description,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get categoryId => _categoryId;
  String? get subcategory => _subcategory;
  String? get image => _image;
  String? get price => _price;
  String? get discountedPrice => _discountedPrice;
  String? get total => _total;
  String? get description => _description;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['subcategory'] = _subcategory;
    map['image'] = _image;
    map['price'] = _price;
    map['discounted_price'] = _discountedPrice;
    map['total'] = _total;
    map['description'] = _description;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
