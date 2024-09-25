class ServiceProviderResponse {
  bool? status;
  String? message;
  List<ServiceProvider>? data;

  ServiceProviderResponse({this.status, this.message, this.data});

  ServiceProviderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceProvider>[];
      json['data'].forEach((v) {
        data!.add(new ServiceProvider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceProvider {
  int? id;
  String? name;
  String? image;
  String? price;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  ServiceProvider(
      {this.id,
        this.name,
        this.image,
        this.price,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
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
