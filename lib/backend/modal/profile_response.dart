class ProfileResponse {
  bool? status;
  String? message;
  ProfileData? data;

  ProfileResponse({this.status, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
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
  String? latitude;///change Double to String
  String? longitude;///change Double to String
  String? isNotification;
  String? isNightMode;
  int? isAvailable;
  int? roleId;
  int? status;
  int? isVerified;
  String? createdAt;
  String? updatedAt;
  UserLocation? userLocation;
  Category? category;

  ProfileData(
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
        this.category,
        this.userLocation});

  ProfileData.fromJson(Map<String, dynamic> json) {
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
    userLocation = json['user_location'] != null
        ? new UserLocation.fromJson(json['user_location'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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
    if (this.userLocation != null) {
      data['user_location'] = this.userLocation!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class UserLocation {
  int? id;
  String? userId;
  String? streetNo;
  String? streetName;
  String? location;
  String? city;
  String? country;
  int? status;
  String? createdAt;
  String? updatedAt;

  UserLocation(
      {this.id,
        this.userId,
        this.streetNo,
        this.streetName,
        this.location,
        this.city,
        this.country,
        this.status,
        this.createdAt,
        this.updatedAt});

  UserLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    streetNo = json['street_no'];
    streetName = json['street_name'];
    location = json['location'];
    city = json['city'];
    country = json['country'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['street_no'] = this.streetNo;
    data['street_name'] = this.streetName;
    data['location'] = this.location;
    data['city'] = this.city;
    data['country'] = this.country;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? price;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  Category({this.id,
    this.name,
    this.image,
    this.price,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
