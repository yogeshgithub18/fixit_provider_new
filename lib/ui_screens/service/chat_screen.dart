import 'dart:async';
import 'dart:io';

import 'package:fixit/backend/api_end_points.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/base_image_network.dart';
import '../../common/color_constants.dart';
import '../../common/utils.dart';
import '../../controller/MessageSendController.dart';
import '../../controller/image_controller.dart';
import '../../storage/base_shared_preference.dart';
import '../../storage/sp_keys.dart';

class ChatScreen extends StatefulWidget {
  final bool isSupportChat;
  final String? name;
  final int? id;
  final String? roomId;
  final String? image;
  bool? isSend;
  ChatScreen(
      {super.key,
      this.isSend,
      this.name,
      this.id,
      this.roomId,
      this.isSupportChat = false,
      this.image});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final imagePickerController = ImagePickerController();
  final record = Record();
  final player = AudioPlayer();
  int? userID;
  int currentIndex = 0;
  Timer? _timer;
  MessageSendController controller = Get.put(MessageSendController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.messageList?.clear();
      userID = await BaseSharedPreference().getInt(SpKeys().userId) ?? "";
      controller.connectSocket(receiverId: widget.id ?? 0, userId: userID!);
    });
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        controller.isPlay.value = false;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.socket?.disconnect();
    controller.socket?.close();
    controller.socket?.destroy();
    controller.socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.h),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Color(0xff039759),
                      )),
                  Container(
                    clipBehavior:
                    Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle),
                    height: 6.h,
                    width: 12.w,
                    child: BaseImageNetwork(
                      fit: BoxFit.fill,
                      link: widget.image ?? '',
                      concatBaseUrl: false,
                      errorWidget: Image.asset(
                        "assets/images/profile.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(widget.image != null
                  //       ? "${ApiEndPoints().imageBaseUrl}${widget.image!}"
                  //       : "https://aws.amazon.com/?nc2=h_lg"),
                  // ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(widget.name!),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          controller: controller.scrollController,
                          padding: EdgeInsets.only(bottom: 2.h),
                          itemCount: (controller.messageList?.length ?? 0),
                          itemBuilder: (context, index1) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.sp),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 1.h, bottom: 1.h),
                                    child: Text(
                                      formatDateToTodayOrYesterday(controller
                                          .messageList![index1].date!),
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(5.sp),
                                    reverse: false,
                                    itemCount: controller.messageList?[index1]
                                            ?.chatList?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      // return Padding(
                                      //   padding: EdgeInsets.only(
                                      //       bottom: index == (controller.messageList?[index1]?.chatList?.length ?? 0) - 1
                                      //           ? 60.0
                                      //           : 10.0),
                                      //   child: Align(
                                      //     alignment: (controller.messageList?[index1]?.chatList?[index].senderId ??
                                      //                 "") !=
                                      //             userID
                                      //         ? Alignment.topLeft
                                      //         : Alignment.topRight,
                                      //     child: Column(
                                      //       crossAxisAlignment: (controller.messageList?[index1]?.chatList?[index].senderId ?? "") != userID
                                      //           ? CrossAxisAlignment.end
                                      //           : CrossAxisAlignment.start,
                                      //       children: [
                                      //         Row(
                                      //           mainAxisSize: MainAxisSize.min,
                                      //           children: [
                                      //             SizedBox(
                                      //               width: 50.w,
                                      //               child: ChatBubble(
                                      //                 backGroundColor:
                                      //                     const Color(0xff039759),
                                      //                 clipper: ChatBubbleClipper5(
                                      //                     type: (controller.messageList?[index1].chatList?[index].senderId?? "") != userID
                                      //                         ? BubbleType.receiverBubble
                                      //                         : BubbleType.sendBubble),
                                      //                 child: Column(
                                      //                   mainAxisSize: MainAxisSize.min,
                                      //                   mainAxisAlignment: MainAxisAlignment.center,
                                      //                   crossAxisAlignment: (controller.messageList?[index1].chatList?[index].senderId?? "") != userID? CrossAxisAlignment.start:CrossAxisAlignment.end,
                                      //                   children: [
                                      //                     if (controller.messageList?[index1]?.chatList?[index].type == "text")
                                      //                       Text(
                                      //                         controller.messageList?[index1]?.chatList?[index].caption ?? "",
                                      //                         style: TextStyle(
                                      //                           fontSize: 16.sp,
                                      //                           color: Colors.white,
                                      //                           fontWeight:
                                      //                               FontWeight.w400,
                                      //                         ),
                                      //                         textAlign:
                                      //                             TextAlign.start,
                                      //                       ),
                                      //                     if (controller.messageList?[index1].chatList?[index].type ==
                                      //                         "audio")
                                      //                       GestureDetector(
                                      //                         onTap: () async {
                                      //                           final duration = await player.setUrl(controller.messageList![index1]?.chatList?[index].audioUrl??"");
                                      //                           print(
                                      //                               "duration---$duration");
                                      //                           player.play();
                                      //                         },
                                      //                         child: Text(
                                      //                           " Tap To Play",
                                      //                           style: TextStyle(
                                      //                             fontSize: 16.sp,
                                      //                             color: Colors.white,
                                      //                             fontWeight:
                                      //                                 FontWeight.w400,
                                      //                           ),
                                      //                           textAlign:
                                      //                               TextAlign.start,
                                      //                         ),
                                      //                       ),
                                      //                     if (controller.messageList?[index1].chatList?[index].type == "image")
                                      //                        Image.network(controller.messageList?[index1]?.chatList?[index].caption?? "",
                                      //                       height: 50.h,width: 50.w, ),
                                      //                       // Text(controller.messageList?[index1].caption ??
                                      //                       //     ""),
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         SizedBox(height: .5.h),
                                      //         addText(
                                      //             // formatMillisecondsToTime(int.parse(
                                      //             //     controller.messageList![index1]
                                      //             //         .createdAtTimestemp!)),
                                      //             controller.messageList?[index1]?.chatList?[index].createdAt ??"",
                                      //             13.sp,
                                      //             Theme.of(context)
                                      //                 .colorScheme
                                      //                 .tertiary,
                                      //             FontWeight.w400),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // );
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: index ==
                                                    (controller
                                                                .messageList?[
                                                                    index1]
                                                                ?.chatList
                                                                ?.length ??
                                                            0) -
                                                        1
                                                ? 60.0
                                                : 10.0),
                                        child: Align(
                                          alignment: (controller
                                                      .messageList?[index1]
                                                      ?.chatList?[index]
                                                      .senderId) !=
                                                  userID
                                              ? Alignment.topLeft
                                              : Alignment.topRight,
                                          child: Column(
                                            crossAxisAlignment: (controller
                                                        .messageList?[index1]
                                                        ?.chatList?[index]
                                                        .senderId) !=
                                                    userID
                                                ? CrossAxisAlignment.start
                                                : CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: (controller
                                                                    .messageList?[
                                                                        index1]
                                                                    ?.chatList?[
                                                                        index]
                                                                    .senderId) !=
                                                                userID
                                                            ? 2.w
                                                            : 0),
                                                    constraints: BoxConstraints(
                                                        minWidth: 10.w,
                                                        maxWidth: 60.w),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    decoration: controller
                                                                .messageList?[
                                                                    index1]
                                                                .chatList?[
                                                                    index]
                                                                .type ==
                                                            "image"
                                                        ? null
                                                        : BoxDecoration(
                                                            color: (controller
                                                                        .messageList?[
                                                                            index1]
                                                                        ?.chatList?[
                                                                            index]
                                                                        .senderId) !=
                                                                    userID
                                                                ? ColorConstants
                                                                    .hintTextLight
                                                                : ColorConstants
                                                                    .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (controller
                                                                .messageList?[
                                                                    index1]
                                                                .chatList?[
                                                                    index]
                                                                .type ==
                                                            "image")
                                                          Image.network(
                                                            controller
                                                                    .messageList?[
                                                                        index1]
                                                                    ?.chatList?[
                                                                        index]
                                                                    .caption ??
                                                                "",
                                                            height: 30.h,
                                                            width: 50.w,
                                                          ),
                                                        // Text(controller.messageList?[index1].caption ??
                                                        //     ""),
                                                        if (controller
                                                                .messageList?[
                                                                    index1]
                                                                .chatList?[
                                                                    index]
                                                                .type ==
                                                            "audio")
                                                          Obx(() => Row(
                                                                children: [
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (controller.playerIndex.value ==
                                                                            index) {
                                                                          controller
                                                                              .playerIndex
                                                                              .value = index;
                                                                          await player
                                                                              .setUrl(controller.messageList![index1].chatList![index].caption!)
                                                                              .then((value) => {});
                                                                          if (controller
                                                                              .isPlay
                                                                              .value) {
                                                                            controller.isPlay.value =
                                                                                !controller.isPlay.value;
                                                                            player.stop();
                                                                          } else {
                                                                            controller.isPlay.value =
                                                                                !controller.isPlay.value;
                                                                            player.play();
                                                                          }
                                                                        } else {
                                                                          controller
                                                                              .isPlay
                                                                              .value = false;
                                                                          controller
                                                                              .playerIndex
                                                                              .value = index;
                                                                          await player
                                                                              .setUrl(controller.messageList![index1].chatList![index].caption!)
                                                                              .then((value) => {});
                                                                          if (controller
                                                                              .isPlay
                                                                              .value) {
                                                                            controller.isPlay.value =
                                                                                !controller.isPlay.value;
                                                                            player.stop();
                                                                          } else {
                                                                            controller.isPlay.value =
                                                                                !controller.isPlay.value;
                                                                            player.play();
                                                                          }
                                                                        }
                                                                      },
                                                                      child: Icon((controller.playerIndex.value == index &&
                                                                              controller
                                                                                  .isPlay.value)
                                                                          ? Icons
                                                                              .pause
                                                                          : Icons
                                                                              .play_circle)),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    "Audio File"
                                                                        .tr,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16.sp,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  )
                                                                ],
                                                              )),
                                                        if (controller
                                                                .messageList?[
                                                                    index1]
                                                                .chatList?[
                                                                    index]
                                                                .type ==
                                                            "text")
                                                          Text(
                                                            controller
                                                                    .messageList?[
                                                                        index1]
                                                                    ?.chatList?[
                                                                        index]
                                                                    .caption ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color: ColorConstants
                                                                  .scaffoldLight,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 0.8.h),
                                              addText(
                                                  getFormattedTime(controller
                                                          .messageList?[index1]
                                                          ?.chatList?[index]
                                                          .createdAt ??
                                                      ""),
                                                  14.sp,
                                                  Colors.grey.shade600,
                                                  FontWeight.w400),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
              Padding(
                padding: Platform.isIOS
                    ? EdgeInsets.only(bottom: 20.sp)
                    : EdgeInsets.only(bottom: 0.sp),
                child: Container(
                  height: 7.h,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.msg,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Message'.tr,
                                hintStyle: TextStyle(
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .error),
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: ColorConstants.primaryColor,
                          ),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final XFile? photo = await picker.pickImage(
                                source: ImageSource.camera);
                            // ignore: unnecessary_null_comparison
                            if (photo != null) {
                              controller.selectedFile?.value =
                                  File(photo!.path);
                            }
                            controller.getLink(widget.id, "image");
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.mic,
                            color: ColorConstants.primaryColor,
                          ),
                          onPressed: () async {
                            if (await record.hasPermission()) {
                              Directory directery =
                                  await getTemporaryDirectory();
                              print(" sssss$directery");
                              final filepath =
                                  '${directery.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
                              await record.start(
                                path: filepath,
                                encoder: AudioEncoder.aacLc, // by default
                                bitRate: 128000, // by default
                                samplingRate: 44100, // by default
                              );
                              controller.recordDuration.value = 0;
                              _startTimer();
                              Get.dialog(
                                AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title:
                                      Center(child: Text('Voice Message'.tr)),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.mic,
                                          size: 40, color: Color(0xff039759)),
                                      Obx(() => _buildTimer()),
                                      Text(
                                        'Recording has been Started'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(Get.context!)
                                                .colorScheme
                                                .tertiary),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    Center(
                                      child: TextButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.deepOrange),
                                          elevation:
                                              MaterialStatePropertyAll(1),
                                        ),
                                        onPressed: () async {
                                          _timer?.cancel();
                                          controller.recordDuration.value = 0;
                                          final path = await record.stop();
                                          print("path of audio file-->$path");
                                          if (path != null) {
                                            controller.selectedFile?.value =
                                                File(path);
                                          }
                                          String? link = await controller
                                              .getLink(widget.id, "audio");
                                          // if(link!=null){
                                          //  await controller.sendMessage(widget.id,widget.roomId,link,"audio");
                                          // }
                                          Get.back();
                                        },
                                        child: Text(
                                          'Send'.tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            // await startRecording();
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: ColorConstants.primaryColor,
                          ),
                          onPressed: () {
                            if (controller.msg.text.isNotEmpty)
                              controller.sendMessage(
                                  widget.id, controller.msg.text, "text", "");
                            controller.msg.clear();
                            // if (_messageController.text.isNotEmpty) {
                            //   setState(() {
                            //     messages.add(ChatMessage(
                            //       text: _messageController.text,
                            //       time: DateTime.now().toString(),
                            //     ));
                            //     _messageController.clear();
                            //   });
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(controller.recordDuration.value ~/ 60);
    final String seconds = _formatNumber(controller.recordDuration.value % 60);
    print("---------->$minutes:$seconds");
    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.cyan),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => controller.recordDuration.value++);
    });
  }

  String formatMillisecondsToTime(int milliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String amPm = dateTime.hour >= 12 ? 'PM'.tr : 'AM'.tr;
    int hourIn12HourFormat =
        dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    String formattedHour = hourIn12HourFormat.toString().padLeft(2, '0');
    String formattedMinute = dateTime.minute.toString().padLeft(2, '0');
    String formattedTime = '$formattedHour:$formattedMinute $amPm';
    return formattedTime;
  }

  String getFormattedTime(String dateString1) {
    if (dateString1.isEmpty) {
      return '';
    }
    DateTime date = DateTime.parse(dateString1);
    String formattedTime = DateFormat('hh:mm a').format(date.toLocal());
    return formattedTime;
  }

  Future<void> startRecording() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
    ].request();

    bool permissionsGranted = permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted;

    if (permissionsGranted) {
      final path = await getTemporaryDirectory();

      final filepath = '$path/${DateTime.now().millisecondsSinceEpoch}.rn';
      print(filepath);
    } else {
      print('Permissions not granted');
    }
  }

  String formatDateToTodayOrYesterday(String inputDate) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime date = dateFormat.parse(inputDate);
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
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
