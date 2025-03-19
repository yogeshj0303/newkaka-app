import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));
String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    required this.error,
    this.data,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      error: json['error'],
      data: (json['data'] as List?)?.map((v) => Data.fromJson(v)).toList(),
    );
  }

  final bool error;
  final List<Data>? data;

  Map<String, dynamic> toJson() => {
    'error': error,
    'data': data?.map((v) => v.toJson()).toList(),
  };
}


class Data {
  Data({
    this.id,
    this.categoryId,
    this.subcategory,
    this.image,
    this.otherImages,
    this.video,
    this.price,
    this.discountedPrice,
    this.total,
    this.description,
    this.deals,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.wishlist,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: int.tryParse(json['id']?.toString() ?? ''),
      categoryId: json['category_id'],
      subcategory: json['subcategory'],
      image: json['image'],
      otherImages: json['other_images'],
      video: json['video'],
      price: json['price'],
      discountedPrice: json['discounted_price'],
      total: json['total'],
      description: json['description'],
      deals: int.tryParse(json['deals']?.toString() ?? ''),
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      wishlist: json['wishlist'],
    );
  }

  final int? id;
  final String? categoryId;
  final String? subcategory;
  final String? image;
  final String? otherImages;
  final String? video;
  final String? price;
  final String? discountedPrice;
  final String? total;
  final String? description;
  final int? deals;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final bool? wishlist;

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_id': categoryId,
    'subcategory': subcategory,
    'image': image,
    'other_images': otherImages,
    'video': video,
    'price': price,
    'discounted_price': discountedPrice,
    'total': total,
    'description': description,
    'deals': deals,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'wishlist': wishlist,
  };
}
