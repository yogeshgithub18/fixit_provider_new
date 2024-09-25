class ChatHistory {
  bool? success;
  ChatData? data;
  String? message;

  ChatHistory({this.success, this.data, this.message});

  ChatHistory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ChatData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ChatData {
  List<ChatHistoryData>? data;
  String? profileImgUrl;

  ChatData({this.data, this.profileImgUrl});

  ChatData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatHistoryData>[];
      json['data'].forEach((v) {
        data!.add(ChatHistoryData.fromJson(v));
      });
    }
    profileImgUrl = json['profile_img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['profile_img_url'] = this.profileImgUrl;
    return data;
  }
}

class ChatHistoryData {
  int? id;
  int? userId;
  int? friendId;
    String? lastMessage;
  String? lastMessageTime;
  String? lastMessageTimestamp;
  String? roomId;
  String? type;
  Friend? friend;

  ChatHistoryData(
      {this.id,
        this.userId,
        this.friendId,
        this.lastMessage,
        this.lastMessageTime,
        this.lastMessageTimestamp,
        this.roomId,
        this.type,
        this.friend});

  ChatHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    friendId = json['friend_id'];
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    lastMessageTimestamp = json['last_message_timestamp'];
    roomId = json['room_id'];
    type = json['type'];
    friend =
    json['friend'] != null ? new Friend.fromJson(json['friend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['friend_id'] = this.friendId;
    data['last_message'] = this.lastMessage;
    data['last_message_time'] = this.lastMessageTime;
    data['last_message_timestamp'] = this.lastMessageTimestamp;
    data['room_id'] = this.roomId;
    data['type'] = this.type;
    if (this.friend != null) {
      data['friend'] = this.friend!.toJson();
    }
    return data;
  }
}

class Friend {
  int? id;
  String? name;
  String? email;
  int? mobileNo;
  int? isPrivate;
  String? bio;
  String ? gender;
  String? username;
  String? countryCode;
  String? profileImage;

  Friend(
      {this.id,
        this.name,
        this.email,
        this.mobileNo,
        this.isPrivate,
        this.bio,
        this.gender,
        this.username,
        this.countryCode,
        this.profileImage});

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    isPrivate = json['is_private'];
    bio = json['bio'];
    gender = json['gender'];
    username = json['username'];
    countryCode = json['country_code'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['is_private'] = this.isPrivate;
    data['bio'] = this.bio;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['country_code'] = this.countryCode;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
