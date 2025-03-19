import 'dart:convert';

ShowOrderModel showOrderModelFromJson(String str) =>
    ShowOrderModel.fromJson(json.decode(str));
String showOrderModelToJson(ShowOrderModel data) => json.encode(data.toJson());

class ShowOrderModel {
  ShowOrderModel({
    bool? error,
    List<Orders>? orders,
  }) {
    _error = error;
    _orders = orders;
  }

  ShowOrderModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        _orders?.add(Orders.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Orders>? _orders;
  ShowOrderModel copyWith({
    bool? error,
    List<Orders>? orders,
  }) =>
      ShowOrderModel(
        error: error ?? _error,
        orders: orders ?? _orders,
      );
  bool? get error => _error;
  List<Orders>? get orders => _orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_orders != null) {
      map['orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));
String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  Orders({
    String? orderid,
    Address? address,
    List<Orderdetails>? orderdetails,
  }) {
    _orderid = orderid;
    _address = address;
    _orderdetails = orderdetails;
  }

  Orders.fromJson(dynamic json) {
    _orderid = json['orderid'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['orderdetails'] != null) {
      _orderdetails = [];
      json['orderdetails'].forEach((v) {
        _orderdetails?.add(Orderdetails.fromJson(v));
      });
    }
  }
  String? _orderid;
  Address? _address;
  List<Orderdetails>? _orderdetails;
  Orders copyWith({
    String? orderid,
    Address? address,
    List<Orderdetails>? orderdetails,
  }) =>
      Orders(
        orderid: orderid ?? _orderid,
        address: address ?? _address,
        orderdetails: orderdetails ?? _orderdetails,
      );
  String? get orderid => _orderid;
  Address? get address => _address;
  List<Orderdetails>? get orderdetails => _orderdetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderid'] = _orderid;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_orderdetails != null) {
      map['orderdetails'] = _orderdetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Orderdetails orderdetailsFromJson(String str) =>
    Orderdetails.fromJson(json.decode(str));
String orderdetailsToJson(Orderdetails data) => json.encode(data.toJson());

class Orderdetails {
  Orderdetails({
    num? id,
    String? customerid,
    String? orderid,
    String? subcategorieid,
    String? quantity,
    String? image,
    String? subcategoryName,
    String? addressId,
    String? total,
    String? orderDate,
    String? status,
    String? activeStatus,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _customerid = customerid;
    _orderid = orderid;
    _subcategorieid = subcategorieid;
    _quantity = quantity;
    _image = image;
    _subcategoryName = subcategoryName;
    _addressId = addressId;
    _total = total;
    _orderDate = orderDate;
    _status = status;
    _activeStatus = activeStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Orderdetails.fromJson(dynamic json) {
    _id = json['id'];
    _customerid = json['customerid'];
    _orderid = json['orderid'];
    _subcategorieid = json['subcategorieid'];
    _quantity = json['quantity'];
    _image = json['image'];
    _subcategoryName = json['subcategory_name'];
    _addressId = json['address_id'];
    _total = json['total'];
    _orderDate = json['order_date'];
    _status = json['status'];
    _activeStatus = json['active_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _customerid;
  String? _orderid;
  String? _subcategorieid;
  String? _quantity;
  String? _image;
  String? _subcategoryName;
  String? _addressId;
  String? _total;
  String? _orderDate;
  String? _status;
  String? _activeStatus;
  String? _createdAt;
  String? _updatedAt;
  Orderdetails copyWith({
    num? id,
    String? customerid,
    String? orderid,
    String? subcategorieid,
    String? quantity,
    String? image,
    String? subcategoryName,
    String? addressId,
    String? total,
    String? orderDate,
    String? status,
    String? activeStatus,
    String? createdAt,
    String? updatedAt,
  }) =>
      Orderdetails(
        id: id ?? _id,
        customerid: customerid ?? _customerid,
        orderid: orderid ?? _orderid,
        subcategorieid: subcategorieid ?? _subcategorieid,
        quantity: quantity ?? _quantity,
        image: image ?? _image,
        subcategoryName: subcategoryName ?? _subcategoryName,
        addressId: addressId ?? _addressId,
        total: total ?? _total,
        orderDate: orderDate ?? _orderDate,
        status: status ?? _status,
        activeStatus: activeStatus ?? _activeStatus,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get customerid => _customerid;
  String? get orderid => _orderid;
  String? get subcategorieid => _subcategorieid;
  String? get quantity => _quantity;
  String? get image => _image;
  String? get subcategoryName => _subcategoryName;
  String? get addressId => _addressId;
  String? get total => _total;
  String? get orderDate => _orderDate;
  String? get status => _status;
  String? get activeStatus => _activeStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['customerid'] = _customerid;
    map['orderid'] = _orderid;
    map['subcategorieid'] = _subcategorieid;
    map['quantity'] = _quantity;
    map['image'] = _image;
    map['subcategory_name'] = _subcategoryName;
    map['address_id'] = _addressId;
    map['total'] = _total;
    map['order_date'] = _orderDate;
    map['status'] = _status;
    map['active_status'] = _activeStatus;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
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

  Address.fromJson(dynamic json) {
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
  Address copyWith({
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
      Address(
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
