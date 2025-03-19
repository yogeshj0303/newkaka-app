import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));
String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  SubCategoryModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
  SubCategoryModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      SubCategoryModel(
        error: error ?? _error,
        data: data ?? _data,
      );
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    int? id,
    String? categoryId,
    String? subcategory,
    String? image,
    String? otherImages,
    String? video,
    String? price,
    String? discountedPrice,
    String? total,
    String? description,
    int? deals,
    String? status,
    String? createdAt,
    String? updatedAt,
    bool? wishlist,
  }) {
    _id = id;
    _categoryId = categoryId;
    _subcategory = subcategory;
    _image = image;
    _otherImages = otherImages;
    _video = video;
    _price = price;
    _discountedPrice = discountedPrice;
    _total = total;
    _description = description;
    _deals = deals;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _wishlist = wishlist;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategory = json['subcategory'];
    _image = json['image'];
    _otherImages = json['other_images'];
    _video = json['video'];
    _price = json['price'];
    _discountedPrice = json['discounted_price'];
    _total = json['total'];
    _description = json['description'];
    _deals = json['deals'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _wishlist = json['wishlist'];
  }
  int? _id;
  String? _categoryId;
  String? _subcategory;
  String? _image;
  String? _otherImages;
  String? _video;
  String? _price;
  String? _discountedPrice;
  String? _total;
  String? _description;
  int? _deals;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  bool? _wishlist;
  Data copyWith({
    int? id,
    String? categoryId,
    String? subcategory,
    String? image,
    String? otherImages,
    String? video,
    String? price,
    String? discountedPrice,
    String? total,
    String? description,
    int? deals,
    String? status,
    String? createdAt,
    String? updatedAt,
    bool? wishlist,
  }) =>
      Data(
        id: id ?? _id,
        categoryId: categoryId ?? _categoryId,
        subcategory: subcategory ?? _subcategory,
        image: image ?? _image,
        otherImages: otherImages ?? _otherImages,
        video: video ?? _video,
        price: price ?? _price,
        discountedPrice: discountedPrice ?? _discountedPrice,
        total: total ?? _total,
        description: description ?? _description,
        deals: deals ?? _deals,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        wishlist: wishlist ?? _wishlist,
      );
  int? get id => _id;
  String? get categoryId => _categoryId;
  String? get subcategory => _subcategory;
  String? get image => _image;
  String? get otherImages => _otherImages;
  String? get video => _video;
  String? get price => _price;
  String? get discountedPrice => _discountedPrice;
  String? get total => _total;
  String? get description => _description;
  int? get deals => _deals;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  bool? get wishlist => _wishlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['subcategory'] = _subcategory;
    map['image'] = _image;
    map['other_images'] = _otherImages;
    map['video'] = _video;
    map['price'] = _price;
    map['discounted_price'] = _discountedPrice;
    map['total'] = _total;
    map['description'] = _description;
    map['deals'] = _deals;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['wishlist'] = _wishlist;
    return map;
  }
}
