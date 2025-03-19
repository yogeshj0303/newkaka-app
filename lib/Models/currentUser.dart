class currentUser {
  bool? error;
  Data? data;

  static currentUser value = currentUser();

  currentUser({this.error, this.data});

  currentUser.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? loginStatus;
  String? name;
  String? phone;
  String? city;
  String? otp;
  String? status;
  String? password;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.loginStatus,
        this.name,
        this.phone,
        this.city,
        this.otp,
        this.status,
        this.password,
        this.createdAt,
        this.updatedAt,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginStatus = json['login_status'];
    name = json['name'];
    phone = json['phone'];
    city = json['city'];
    otp = json['otp'];
    status = json['status'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login_status'] = this.loginStatus;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}