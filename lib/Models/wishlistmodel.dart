import 'dart:convert';

WishListModel wishListModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));
String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  WishListModel({
    bool? error,
    List<Data>? data,
    String? message,
  }) {
    _error = error;
    _data = data;
    _message = message;
  }

  WishListModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _error;
  List<Data>? _data;
  String? _message;
  WishListModel copyWith({
    bool? error,
    List<Data>? data,
    String? message,
  }) =>
      WishListModel(
        error: error ?? _error,
        data: data ?? _data,
        message: message ?? _message,
      );
  bool? get error => _error;
  List<Data>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? id,
    String? customerId,
    String? subcategorieId,
    String? createdAt,
    String? updatedAt,
    Subcategorie? subcategorie,
    bool? wishlist,
  }) {
    _id = id;
    _customerId = customerId;
    _subcategorieId = subcategorieId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _subcategorie = subcategorie;
    _wishlist = wishlist;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _subcategorieId = json['subcategorie_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _subcategorie = json['subcategorie'] != null
        ? Subcategorie.fromJson(json['subcategorie'])
        : null;
    _wishlist = json['wishlist'];
  }
  num? _id;
  String? _customerId;
  String? _subcategorieId;
  String? _createdAt;
  String? _updatedAt;
  Subcategorie? _subcategorie;
  bool? _wishlist;
  Data copyWith({
    num? id,
    String? customerId,
    String? subcategorieId,
    String? createdAt,
    String? updatedAt,
    Subcategorie? subcategorie,
    bool? wishlist,
  }) =>
      Data(
        id: id ?? _id,
        customerId: customerId ?? _customerId,
        subcategorieId: subcategorieId ?? _subcategorieId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        subcategorie: subcategorie ?? _subcategorie,
        wishlist: wishlist ?? _wishlist,
      );
  num? get id => _id;
  String? get customerId => _customerId;
  String? get subcategorieId => _subcategorieId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Subcategorie? get subcategorie => _subcategorie;
  bool? get wishlist => _wishlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['customer_id'] = _customerId;
    map['subcategorie_id'] = _subcategorieId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_subcategorie != null) {
      map['subcategorie'] = _subcategorie?.toJson();
    }
    map['wishlist'] = _wishlist;
    return map;
  }
}

Subcategorie subcategorieFromJson(String str) =>
    Subcategorie.fromJson(json.decode(str));
String subcategorieToJson(Subcategorie data) => json.encode(data.toJson());

class Subcategorie {
  Subcategorie({
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

  Subcategorie.fromJson(dynamic json) {
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
  Subcategorie copyWith({
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
      Subcategorie(
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
