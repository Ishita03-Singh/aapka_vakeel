// import 'package:aapka_vakeel/utilities/custom_button.dart';
// import 'package:aapka_vakeel/utilities/custom_text.dart';
// import 'package:aapka_vakeel/utilities/my_appbar.dart';
// import 'package:aapka_vakeel/utilities/strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:uuid/uuid.dart';



// class VideoCall extends StatefulWidget {
//   final String data;

//   const VideoCall({super.key,required this.data});

//   @override
//   State<VideoCall> createState() => _VideoCallState();
// }

// class _VideoCallState extends State<VideoCall> {

//    late RTCPeerConnection _peerConnection;
//   late MediaStream _localStream;
//   final _localRenderer = RTCVideoRenderer();
//   final _remoteRenderer = RTCVideoRenderer();
//   final _uuid = Uuid();

//    @override
//   void initState() {
//     super.initState();
//     _initializeRenderers();
//     _createPeerConnection().then((pc) {
//       _peerConnection = pc;
//     });
//   }
  
//     @override
//   void dispose() {
//     _localRenderer.dispose();
//     _remoteRenderer.dispose();
//     _localStream.dispose();
//     _peerConnection.close();
//     super.dispose();
//   }

//   Future<void> _initializeRenderers() async {
//     await _localRenderer.initialize();
//     await _remoteRenderer.initialize();
//     _getUserMedia();
//   }

//   Future<void> _getUserMedia() async {
//     final mediaConstraints = {
//       'audio': true,
//       'video': true
//     };

//     MediaStream stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
//     _localRenderer.srcObject = stream;
//     _localStream = stream;

//     _localStream.getTracks().forEach((track) {
//       _peerConnection.addTrack(track, _localStream);
//     });
//   }

//   Future<RTCPeerConnection> _createPeerConnection() async {
//     final config = {
//       'iceServers': [
//         {'url': 'stun:stun.l.google.com:19302'},
//       ]
//     };

//     final pc = await createPeerConnection(config);

//     pc.onIceCandidate = (RTCIceCandidate candidate) {
//       // Handle ICE candidate
//     };

//     pc.onIceConnectionState = (RTCIceConnectionState state) {
//       print('ICE connection state: $state');
//     };

//     pc.onAddStream = (MediaStream stream) {
//       print('Add remote stream');
//       _remoteRenderer.srcObject = stream;
//     };

//     return pc;
//   }


//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//     appBar: MyAppBar.appbar(context),
//     body: Container(
//       padding: EdgeInsets.all(13),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//             CustomText.headText("Start Meeting"),
//             SizedBox(height: 8),
//              Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                               padding: EdgeInsets.all(30),
//                               width: MediaQuery.of(context).size.width/1.3,
//                               height: MediaQuery.of(context).size.height/4,
//                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),
//                               border: Border.all(
//                               color: Colors.grey, // Set the border color here
//                               width: 1.0, // Set the border width here
//                                ),),
                               
       
//                               child: RTCVideoView(_localRenderer, mirror: true),
                              
//                                               ),
                            
//                              SizedBox(height: 8),
//                               Row(mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                 customButton.rectIconButton(context, "video", Icons.videocam_off_outlined, (){
//                                                 //open camera

//                                               }),
//                                               SizedBox(width: 8),
//                                                customButton.rectIconButton(context, "mic", Icons.mic_off_rounded, (){
//                                                 //open camera
//                                               }),
//                                               ],)
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 22),
            
//                         CustomText.boldinfoText("Instructions :"),
//                         SizedBox(height: 8),

//                         CustomText.infoText('1. Make sure your camera is properly working.\n2. Ensure your voice is clearly audible.\n3. Keep your original documents in hand.\n4.When ready, tap the "Start" button to start the meeting.'),
                        
            
                
//                 ],),

//           ),
//           customButton.taskButton("Start", (){
//                           //start meeting
//                           _createOffer();
//                         })
//         ],
//       )),
//     );
//   }

//   Future<void> _createOffer() async {
//     RTCSessionDescription description = await _peerConnection.createOffer({
//       'offerToReceiveAudio': 1,
//       'offerToReceiveVideo': 1,
//     });
//     _peerConnection.setLocalDescription(description);
//     // Send the offer to the remote peer using your signaling method
//   }

//   Future<void> _createAnswer() async {
//     RTCSessionDescription description = await _peerConnection.createAnswer({
//       'offerToReceiveAudio': 1,
//       'offerToReceiveVideo': 1,
//     });
//     _peerConnection.setLocalDescription(description);
//     // Send the answer to the remote peer using your signaling method
//   }

//   void _setRemoteDescription(RTCSessionDescription description) {
//     _peerConnection.setRemoteDescription(description);
//   }

//   void _addCandidate(RTCIceCandidate candidate) {
//     _peerConnection.addCandidate(candidate);
//   }
// }


// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:provider/provider.dart';

// // // void main() {
// // //   runApp(
// // //     ChangeNotifierProvider(
// // //       create: (context) => VideoCallProvider(),
// // //       child: MyApp(),
// // //     ),
// // //   );
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: VideoCallSetupScreen(),
// // //     );
// // //   }
// // // }
// // class VideoCallSetupScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     var provider = Provider.of<VideoCallProvider>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Video Call Setup'),
// //       ),
// //       body: FutureBuilder(
// //         future: provider.initializeCamera(),
// //         builder: (context, snapshot) {
// //           // if (snapshot.connectionState == ConnectionState.done) {
// //             if (snapshot.hasError) {
// //               return Center(child: Text('Error initializing camera: ${snapshot.error}'));
// //             }
// //             return Column(
// //               children: [
// //                 AspectRatio(
// //                   aspectRatio: 1.0,
// //                   child: provider.controller != null
// //                       ? CameraPreview(provider.controller!)
// //                       : Container(color: Colors.black),
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     IconButton(
// //                       icon: Icon(
// //                         provider.isCameraOn ? Icons.videocam : Icons.videocam_off,
// //                         color: provider.isCameraOn ? Colors.green : Colors.red,
// //                       ),
// //                       onPressed: () {
// //                         provider.toggleCamera();
// //                       },
// //                     ),
// //                     IconButton(
// //                       icon: Icon(
// //                         provider.isMicOn ? Icons.mic : Icons.mic_off,
// //                         color: provider.isMicOn ? Colors.green : Colors.red,
// //                       ),
// //                       onPressed: () {
// //                         provider.toggleMic();
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     // Implement your join meeting functionality here
// //                     print('Joining meeting...');
// //                   },
// //                   child: Text('Join Meeting'),
// //                 ),
// //               ],
// //             );
// //           // } else if (snapshot.connectionState == ConnectionState.waiting) {
// //           //   return Center(child: CircularProgressIndicator());
// //           // } else {
// //           //   return Center(child: Text('Initializing...'));
// //           // }
// //         },
// //       ),
// //     );
// //   }
// // }

// // class VideoCallProvider with ChangeNotifier {
// //   late List<CameraDescription> cameras;
// //   CameraController? controller;
// //   bool _isCameraOn = true;
// //   bool _isMicOn = true;

// //   VideoCallProvider() {
// //     _initializeCameras();
// //   }

// //   bool get isCameraOn => _isCameraOn;
// //   bool get isMicOn => _isMicOn;

// //   Future<void> _initializeCameras() async {
// //     try {
// //       cameras = await availableCameras();
// //       await initializeCamera();
// //     } catch (e) {
// //       print('Error initializing cameras: $e');
// //     }
// //   }

// //   Future<void> initializeCamera() async {
// //     if (await _requestPermissions()) {
// //       if (cameras.isNotEmpty) {
// //         controller = CameraController(cameras[0], ResolutionPreset.high);
// //         controller?.addListener(() {
// //           if (controller!.value.hasError) {
// //             print('Camera error: ${controller!.value.errorDescription}');
// //           }
// //         });
// //         try {
// //           await controller?.initialize();
// //           notifyListeners();
// //         } catch (e) {
// //           print('Error initializing camera: $e');
// //         }
// //       } else {
// //         throw Exception('No cameras available');
// //       }
// //     } else {
// //       throw Exception('Camera permissions not granted');
// //     }
// //     return;
// //   }

// //   Future<bool> _requestPermissions() async {
// //     var cameraStatus = await Permission.camera.request();
// //     var micStatus = await Permission.microphone.request();
// //     return cameraStatus.isGranted && micStatus.isGranted;
// //   }

// //   void toggleCamera() async {
// //     _isCameraOn = !_isCameraOn;
// //     if (_isCameraOn) {
// //       await initializeCamera();
// //     } else {
// //       await controller?.dispose();
// //       controller = null; // Set controller to null when disposed
// //     }
// //     notifyListeners();
// //   }

// //   void toggleMic() {
// //     _isMicOn = !_isMicOn;
// //     notifyListeners();
// //   }
// // }
