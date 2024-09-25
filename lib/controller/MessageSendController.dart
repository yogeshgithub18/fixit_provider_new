import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fixit/backend/api_end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


import 'package:dio/dio.dart' as dio;

import '../backend/base_api.dart';
import '../backend/modal/chat_message_model.dart';
import '../common/base_overlays.dart';
import '../storage/base_shared_preference.dart';
import '../storage/sp_keys.dart';
class MessageSendController extends GetxController{
  TextEditingController msg=TextEditingController();
  ScrollController scrollController = ScrollController();
  RxList<ChatData>? messageList = <ChatData>[].obs;
  io.Socket? socket;
 RxInt length=0.obs;
 RxBool isPlay= false.obs;
  RxBool isLoading=false.obs;
  RxInt playerIndex=1111111111.obs;
  RxInt recordDuration=0.obs;
  Map<String, dynamic> joinRoomData = {};
  Rx<File>? selectedFile = File("").obs;

  connectSocket({required int receiverId, required int userId}) async {
    isLoading.value=true;
    log("In Socket Method");
    socket = io.io("https://fixitservice.co:4000/",
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        "force new connection": true,
        "reconnectionAttempt": "Infinity",
        "timeout": 10000,
      },
    );
    log("In Socket Method1");
    socket?.connect();
    log("In Socket Method2");
    // final int userId = await BaseSharedPreference().getInt(SpKeys().userId) ?? "";
    //   deprintWrapped("CHAT With user --, --$userId,--$receiverId");
      socket?.onConnect((data) {
        log("Socket Connected");
        socket?.emitWithAck("JOIN_ROOM", {userId,receiverId}, ack: (data){
          printWrapped("JOIN_ROOM:- $data");
        });
        socket?.on("JOIN_ROOM_RESPONSE", (data){
          isLoading.value=false;
          BaseOverlays().dismissOverlay(showLoader:false );
          log("JOIN_ROOM_RESPONSE:- ${json.decode(data)}");
          if(joinRoomData.isEmpty) {
            joinRoomData = json.decode(data);
            print("---room  id---${joinRoomData["data"]["room_id"]},---userId4----$userId,,---receiverId--$receiverId");
            socket?.emitWithAck("CHAT_DETAIL", {joinRoomData["data"]["room_id"], userId,receiverId},
                ack: (data) {
                  printWrapped("CHAT_DETAIL_NEW:- $data");
                });
            socket?.on("CHAT_DETAIL_RESPONSE", (data) {
              printWrapped("RESPONSE--:- $data");
              messageList?.clear();
              messageList?.value = MessageListResponse.fromJson(jsonDecode(data)).data ?? [];
              messageList?.refresh();
              Future.delayed(const Duration(milliseconds: 500), () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              });
            });
          }
        },
        );
      },
      );



    socket?.onDisconnect((_) {
      isLoading.value=false;
      print("Socket Disconnect");
      connectSocket(receiverId: receiverId,userId: userId);
    });
    socket?.onConnectError((_) {
      isLoading.value=false;
      print("Socket Connection Error: $_");
      // connectSocket(receiverId:receiverId);
    });
    socket?.on('error', (data) {
      isLoading.value=false;
      print(data+"_________");
    });
  }

  sendMessage(receiverId, String message, String type,String link) async {
    final int userId = await BaseSharedPreference().getInt(SpKeys().userId) ?? "";
    try {
      socket?.emitWithAck("NEW_MESSAGE", {
        "roomId":joinRoomData["data"]["room_id"],
        "senderId": userId,
        "receiverId": receiverId,
        "caption": message,
        "audioUrl":link,
        "type": type
      }, ack: (data) {
        print("NEW_Data:- $data");
      });
      // socket?.on("NEW_MESSAGE_RESPONSE", (data) {
      //   print("NEW_MESSAGE_RESPONSE:- $data");
      //   if (jsonDecode(data)['status'] == true) {
      //     String roomid=joinRoomData["data"]["room_id"];
      //   socket?.emitWithAck("CHAT_DETAIL_NEW",{roomid, userId,receiverId}, ack: (data) {
      //       print("CHAT_DETAIL_NEW:- $data");
      //     });
      //   } else {
      //    // baseToast(message: (jsonDecode(data)['message'] ?? ""));
      //   }
      //});
    }catch(_){
      print("Exception....$_....");
    }
  }

  Future<String?> getLink(id,type) async {
    try {
      dio.FormData param = dio.FormData.fromMap({
        'type': type,
        'document': await dio.MultipartFile.fromFile(selectedFile!.value.path, filename:selectedFile?.value.path.split("/").last??"")
      });
       await BaseAPI().post(url: ApiEndPoints().sendChatData, data: param,showLoader: false).then((response) async {
        print('response == ${response?.data['data']['link']}');
        if (response?.statusCode == 200) {
          if (response?.data['status'] == true) {
            sendMessage(id,response?.data['data']['link'],type,'');
          }
        }
      });
    } catch (_) {
      print("Exception in createSupportTicketAPI ctrl....$_....");
    }
  }

  String formatDateToTodayOrYesterday(int inputDate) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(inputDate);
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    } else {
      // Format the date using intl package if it's not today or yesterday
      return DateFormat('MMMM d, y').format(date.toLocal());
    }
  }
}
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}