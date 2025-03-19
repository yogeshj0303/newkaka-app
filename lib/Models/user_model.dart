class UserModel {
  final bool error;
  final Data? data;
  final String message;

  UserModel({required this.error, this.data, required this.message});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      error: json['error'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
    );
  }
}

class Data {
  final int? id;
  final int? loginStatus;
  final String? name;
  final String? phone;
  final String? city;
  final String? otp;
  final String? status;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? email;

  Data({
    this.id,
    this.loginStatus,
    this.name,
    this.phone,
    this.city,
    this.otp,
    this.status,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      loginStatus: json['login_status'],
      name: json['name'],
      phone: json['phone'],
      city: json['city'],
      otp: json['otp'],
      status: json['status'],
      password: json['password'],
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
      email: json['email'],
    );
  }
}
