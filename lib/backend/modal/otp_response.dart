class OtpResponse {
  bool? status;
  String? message;
  Data? data;

  OtpResponse({this.status, this.message, this.data});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? emailVerifiedAt;
  String? pwd;
  String? description;
  String? gender;
  String? userLocationId;
  dynamic latitude;
  dynamic longitude;
  String? isNotification;
  String? isNightMode;
  int? isAvailable;
  int? roleId;
  int? status;
  int? isVerified;
  String? createdAt;
  String? updatedAt;
  String? token;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.emailVerifiedAt,
        this.pwd,
        this.description,
        this.gender,
        this.userLocationId,
        this.latitude,
        this.longitude,
        this.isNotification,
        this.isNightMode,
        this.isAvailable,
        this.roleId,
        this.status,
        this.isVerified,
        this.createdAt,
        this.updatedAt,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    pwd = json['pwd'];
    description = json['description'];
    gender = json['gender'];
    userLocationId = json['user_location_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNotification = json['is_notification'];
    isNightMode = json['is_night_mode'];
    isAvailable = json['is_available'];
    roleId = json['role_id'];
    status = json['status'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['pwd'] = this.pwd;
    data['description'] = this.description;
    data['gender'] = this.gender;
    data['user_location_id'] = this.userLocationId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_notification'] = this.isNotification;
    data['is_night_mode'] = this.isNightMode;
    data['is_available'] = this.isAvailable;
    data['role_id'] = this.roleId;
    data['status'] = this.status;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}
