import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));
String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  AddressModel.fromJson(dynamic json) {
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
  AddressModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      AddressModel(
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
    num? id,
    String? customerId,
    String? street,
    String? city,
    String? state,
    String? country,
    String? pinCode,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _customerId = customerId;
    _street = street;
    _city = city;
    _state = state;
    _country = country;
    _pinCode = pinCode;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _street = json['street'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _pinCode = json['pin_code'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _customerId;
  String? _street;
  String? _city;
  String? _state;
  String? _country;
  String? _pinCode;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? customerId,
    String? street,
    String? city,
    String? state,
    String? country,
    String? pinCode,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        customerId: customerId ?? _customerId,
        street: street ?? _street,
        city: city ?? _city,
        state: state ?? _state,
        country: country ?? _country,
        pinCode: pinCode ?? _pinCode,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get customerId => _customerId;
  String? get street => _street;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get pinCode => _pinCode;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['customer_id'] = _customerId;
    map['street'] = _street;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['pin_code'] = _pinCode;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
