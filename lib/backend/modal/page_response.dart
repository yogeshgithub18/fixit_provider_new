class PageResponse {
  bool? status;
  String? message;
  PageData? data;

  PageResponse({this.status, this.message, this.data});

  PageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PageData.fromJson(json['data']) : null;
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

class PageData {
  int? id;
  String? privacyPolicy;
  String? termCondition;
  String? aboutUs;
  String? createdAt;
  String? updatedAt;

  PageData(
      {this.id,
        this.privacyPolicy,
        this.termCondition,
        this.aboutUs,
        this.createdAt,
        this.updatedAt});

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    privacyPolicy = json['privacy_policy'];
    termCondition = json['term_condition'];
    aboutUs = json['about_us'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['privacy_policy'] = this.privacyPolicy;
    data['term_condition'] = this.termCondition;
    data['about_us'] = this.aboutUs;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
