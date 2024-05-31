// import 'dart:convert';
//
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:agora_rtm/agora_rtm.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import '../Widgets/BaseHelper.dart';
// import 'chat_screen.dart';
//
// class Call extends StatefulWidget {
//   final String channelName;
//   final String? TokkenName;
//
//   Call({Key? key, required this.channelName,required this.TokkenName}) : super(key: key);
//
//   @override
//   State<Call> createState() => _CallState();
// }
//
// class _CallState extends State<Call> {
//   late RtcEngine _engine;
//   late int streamId;
//   bool muted = false, loading = false;
//   int _remoteUid = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     initializeAgora();
//   }
//
//   Future<void> initializeAgora() async {
//     setState(() {
//       loading = true;
//     });
//     _engine = await RtcEngine.createWithContext(RtcEngineContext(
//         "adb6d2c7a16c4357baa8b871337bad12")); //goto constant.dart file
//     await _engine.enableVideo();
//     await _engine.enableAudio();
//     await _engine.setChannelProfile(ChannelProfile.Communication);
//     streamId = (await _engine.createDataStream(false, false))!;
//     _engine.setEventHandler(RtcEngineEventHandler(
//       joinChannelSuccess: (channel, uid, elapsed) {
//         // if (kDebugMode) {
//         //   print("onJoinChannel: $channel, uid: $uid");
//         // }
//       },
//       userJoined: (uid, elapsed) {
//         print("UserJoined: $uid");
//         setState(() {
//           _remoteUid = uid;
//         });
//       },
//       userOffline: (uid, elapsed) {
//         // if (kDebugMode) {
//         //   print("Useroffline: $uid");
//         // }
//         setState(() {
//           _remoteUid = 0;
//         });
//       },
//     ));
//     await _engine.joinChannel(widget.TokkenName, widget.channelName, null, 0);
//   }
//
//   fetchDatacallend(String userId) async {
//
//     try {
//       final response = await http.post(Uri.parse("https://doclive.info/api/end_call/1?user_id=$userId"));
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//          String token = responseData["message"];
//         print("Token: $token");
//         print(responseData);
//       } else {
//         print("Error: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Center(
//               child: _renderRemoteView(),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 100,
//                 height: 130,
//                 margin: EdgeInsets.only(left: 15, top: 15),
//                 child: _renderLocalView(),
//               ),
//             ),
//             _toolbar(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _renderLocalView() {
//     return const RtcLocalView.SurfaceView();
//   }
//
//   Widget _renderRemoteView() {
//     if (_remoteUid != 0) {
//       return RtcRemoteView.SurfaceView(
//         uid: _remoteUid,
//         channelId: widget.channelName,
//       );
//     } else {
//       return const Text("Waiting for other user to join");
//     }
//   }
//
//   Widget _toolbar() {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       margin: const EdgeInsets.only(bottom: 30),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           RawMaterialButton(
//             onPressed: () {
//               _onToggleMute();
//             },
//             shape: const CircleBorder(),
//             padding: const EdgeInsets.all(5),
//             elevation: 2.0,
//             fillColor: (muted) ? Colors.blue : Colors.white,
//             child: Icon(
//               (muted) ? Icons.mic_off : Icons.mic,
//               color: muted ? Colors.white : Colors.blue,
//               size: 40,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () {
//               fetchDatacallend(BaseHelper.ids.toString());
//               _onCallEnd();
//             },
//             shape: const CircleBorder(),
//             padding: const EdgeInsets.all(5),
//             elevation: 2.0,
//             fillColor: Colors.redAccent,
//             child: const Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 50,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () {
//               _onSwitchCamera();
//             },
//             shape: const CircleBorder(),
//             padding: const EdgeInsets.all(5),
//             elevation: 2.0,
//             fillColor: Colors.white,
//             child: const Icon(
//               Icons.switch_camera,
//               color: Colors.blue,
//               size: 40,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ChatScreen()),
//               );
//             },
//             shape: const CircleBorder(),
//             padding: const EdgeInsets.all(5),
//             elevation: 2.0,
//             fillColor: Colors.white,
//             child: const Icon(
//               Icons.chat_outlined,
//               color: Colors.blue,
//               size: 40,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }
//
//   void _onCallEnd() {
//     _engine.leaveChannel().then((value) {
//       Navigator.of(context).pop();
//       //fcmtokens.clear();
//     });
//   }
//
//   void _onSwitchCamera() {
//     _engine.switchCamera();
//   }
// }