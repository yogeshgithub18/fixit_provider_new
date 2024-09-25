class AllBookingsDataModel {
  bool? status;
  String? message;
  List<Data>? data;

  AllBookingsDataModel({this.status, this.message, this.data});

  AllBookingsDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Data {
  int? id;
  String? userId;
  String? userLocationId;
  String? categoryId;
  String? date;
  String? description;
  String? fromTime;
  String? toTime;
  int? status;
  String? serviceProviderId;
  String? pricePerDay;
  int? isAccept;
  int? isClientConfirm;
  int? serviceProviderStatus;
  int? isComplete;
  String? addonPrice;
  String? addonPriceReason;
  String? grandtotal;
  String? rating;
  String? ratingComment;
  int? bookingStatus;
  String? createdAt;
  String? updatedAt;
  dynamic distance;
  User? user;
  Category? category;
  Subcategory? subcategory;
  UserLocation? userLocation;

  Data(
      {this.id,
        this .description,
      this.userId,
      this.userLocationId,
      this.categoryId,
      this.date,
      this.fromTime,
      this.toTime,
      this.status,
      this.serviceProviderId,
      this.pricePerDay,
      this.distance,
      this.isAccept,
        this.isClientConfirm,
      this.serviceProviderStatus,
      this.isComplete,
      this.addonPrice,
      this.addonPriceReason,
      this.grandtotal,
      this.rating,
      this.ratingComment,
      this.bookingStatus,
      this.createdAt,
      this.updatedAt,
      this.category,
        this.subcategory,
        this.user,
      this.userLocation});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json ['description'];
    distance = json ['distance'];
    userId = json['user_id'];
    userLocationId = json['user_location_id'];
    categoryId = json['category_id'];
    date = json['date'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    status = json['status'];
    serviceProviderId = json['service_provider_id'];
    pricePerDay = json['price_per_day'];
    isAccept = json['is_accept'];
    isClientConfirm = json['is_client_confirm'];
    serviceProviderStatus = json['service_provider_status'];
    isComplete = json['is_complete'];
    addonPrice = json['addon_price'];
    addonPriceReason = json['addon_price_reason'];
    grandtotal = json['grandtotal'];
    rating = json['rating'];
    ratingComment = json['rating_comment'];
    bookingStatus = json['booking_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    userLocation = json['user_location'] != null
        ? new UserLocation.fromJson(json['user_location'])
        : null;
    subcategory = json['subcategory'] != null
        ? new Subcategory.fromJson(json['subcategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data ['description'] =description;
    data['user_id'] = userId;
    data['distance'] = distance;
    data['user_location_id'] = userLocationId;
    data['category_id'] = categoryId;
    data['date'] = date;
    data['from_time'] = fromTime;
    data['to_time'] = toTime;
    data['status'] = status;
    data['service_provider_id'] = serviceProviderId;
    data['price_per_day'] = pricePerDay;
    data['is_accept'] = isAccept;
    data['is_client_confirm'] = isClientConfirm;
    data['service_provider_status'] = serviceProviderStatus;
    data['is_complete'] = isComplete;
    data['addon_price'] = addonPrice;
    data['addon_price_reason'] = addonPriceReason;
    data['grandtotal'] = grandtotal;
    data['rating'] = rating;
    data['rating_comment'] = ratingComment;
    data['booking_status'] = bookingStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (userLocation != null) {
      data['user_location'] = userLocation!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  @override
  String toString()=> "Requested userId---$userId---id--$id---name--${user?.name}--image--${user?.image}";
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

  Category(
      {this.id,
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
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Subcategory {
  int? id;
  String? langId;
  String? name;
  String? arName;
  String? kuName;
  String? catId;
  String? description;
  String? price;
  String? arDescription;
  String? image;
  String? darkImage;
  String? kuDescription;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? isDeleted;

  Subcategory(
      {this.id,
        this.langId,
        this.name,
        this.arName,
        this.kuName,
        this.catId,
        this.description,
        this.price,
        this.arDescription,
        this.image,
        this.darkImage,
        this.kuDescription,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isDeleted});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    langId = json['lang_id'];
    name = json['name'];
    arName = json['ar_name'];
    kuName = json['ku_name'];
    catId = json['cat_id'];
    description = json['description'];
    price = json['price'];
    arDescription = json['ar_description'];
    image = json['image'];
    darkImage = json['dark_image'];
    kuDescription = json['ku_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lang_id'] = this.langId;
    data['name'] = this.name;
    data['ar_name'] = this.arName;
    data['ku_name'] = this.kuName;
    data['cat_id'] = this.catId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['ar_description'] = this.arDescription;
    data['image'] = this.image;
    data['dark_image'] = this.darkImage;
    data['ku_description'] = this.kuDescription;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}

class UserLocation {
  int? id;
  String ?latitude;
  String? longitude;
  String? userId;
  String? streetNo;
  String? streetName;
  String? location;
  String? city;
  String? country;
  String? pincode;
  int? status;
  String? createdAt;
  String? updatedAt;

  UserLocation(
      {this.id,
        this .longitude,
        this.latitude,
      this.userId,
      this.streetNo,
      this.streetName,
      this.location,
      this.city,
      this.country,
      this.pincode,
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
    pincode = json['pincode'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['street_no'] = streetNo;
    data['street_name'] = streetName;
    data['location'] = location;
    data['city'] = city;
    data['country'] = country;
    data['pincode'] = pincode;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic emailVerifiedAt;
  String? pwd;
  dynamic description;
  String? gender;
  String? userLocationId;
  String? fcmToken;
  dynamic latitude;
  dynamic longitude;
  String? isNotification;
  String? isNightMode;
  int? isAvailable;
  int? roleId;
  dynamic categoryId;
  int? status;
  int? isOnline;
  int? isVerified;
  String? createdAt;
  String? updatedAt;

  User(
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
        this.fcmToken,
        this.latitude,
        this.longitude,
        this.isNotification,
        this.isNightMode,
        this.isAvailable,
        this.roleId,
        this.categoryId,
        this.status,
        this.isOnline,
        this.isVerified,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
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
    fcmToken = json['fcm_token'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNotification = json['is_notification'];
    isNightMode = json['is_night_mode'];
    isAvailable = json['is_available'];
    roleId = json['role_id'];
    categoryId = json['category_id'];
    status = json['status'];
    isOnline = json['is_online'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['fcm_token'] = this.fcmToken;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_notification'] = this.isNotification;
    data['is_night_mode'] = this.isNightMode;
    data['is_available'] = this.isAvailable;
    data['role_id'] = this.roleId;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['is_online'] = this.isOnline;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}