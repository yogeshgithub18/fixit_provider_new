class MessageListResponse {
  bool? status;
  String? message;
  List<ChatData>? data;

  MessageListResponse({this.status, this.message, this.data});

  MessageListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChatData>[];
      json['data'].forEach((v) {
        data!.add( ChatData.fromJson(v));
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

class ChatData {
  String? date;
  List<ChatList>? chatList;

  ChatData({this.date, this.chatList});

  ChatData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['chatList'] != null) {
      chatList = <ChatList>[];
      json['chatList'].forEach((v) {
        chatList!.add(new ChatList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.chatList != null) {
      data['chatList'] = this.chatList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatList {
  int? id;
  String? roomId;
  int? senderId;
  int? receiverId;
  String? type;
  String? audioUrl;
  String? caption;
  String? isRead;
  String? readTime;
  String? readTimestamp;
  String? createdAt;
  String? createdAtTimestemp;
  Null updatedAt;
  Null deletedAt;
  String? senderName;
  String? senderImage;
  String? receiverName;
  String? receiverImage;
  int? receiverOnline;
  int? senderOnline;


  ChatList(
      {this.id,
        this.roomId,
        this.senderId,
        this.receiverId,
        this.type,
        this.audioUrl,
        this.caption,
        this.isRead,
        this.readTime,
        this.readTimestamp,
        this.createdAt,
        this.createdAtTimestemp,
        this.updatedAt,
        this.deletedAt,
        this.senderName,
        this.senderImage,
        this.receiverName,
        this.receiverImage,
        this.receiverOnline,
        this.senderOnline});

  ChatList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    type = json['type'];
    audioUrl = json['audio_url'];
    caption = json['caption'];
    isRead = json['is_read'];
    readTime = json['read_time'];
    readTimestamp = json['read_timestamp'];
    createdAt = json['created_at'];
    createdAtTimestemp = json['created_at_timestemp'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    senderName = json['senderName'];
    senderImage = json['senderImage'];
    receiverName = json['receiverName'];
    receiverImage = json['receiverImage'];
    receiverOnline = json['receiverOnline'];
    senderOnline = json['senderOnline'];
  }

  get chatList => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room_id'] = this.roomId;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['type'] = this.type;
    data['audio_url'] = this.audioUrl;
    data['caption'] = this.caption;
    data['is_read'] = this.isRead;
    data['read_time'] = this.readTime;
    data['read_timestamp'] = this.readTimestamp;
    data['created_at'] = this.createdAt;
    data['created_at_timestemp'] = this.createdAtTimestemp;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['senderName'] = this.senderName;
    data['senderImage'] = this.senderImage;
    data['receiverName'] = this.receiverName;
    data['receiverImage'] = this.receiverImage;
    data['receiverOnline'] = this.receiverOnline;
    data['senderOnline'] = this.senderOnline;
    return data;
  }
}
