import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sportolingo/linkChange.dart';
import 'package:video_player/video_player.dart';

class VideoRecorderScreen extends StatefulWidget {
  @override
  _VideoRecorderScreenState createState() => _VideoRecorderScreenState();
}

class _VideoRecorderScreenState extends State<VideoRecorderScreen> {
  late CameraController controller;
  late List<CameraDescription> cameras;
  bool isRecording = false;
  String? videoPath;
  bool isCameraInitialized = false;
  bool isFrontal = false;
  bool isUploaded=false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void changeSide()async{
    if(isFrontal){
      controller = CameraController(cameras[0], ResolutionPreset.high);
      await controller.initialize();
      isFrontal = false;
      setState((){});
    }else{
      controller = CameraController(cameras[1], ResolutionPreset.high);
      await controller.initialize();
      isFrontal = true;
      setState((){});
    }
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  Future<void> startRecording() async {
    if (controller.value.isInitialized && !controller.value.isRecordingVideo) {
      final directory = await getTemporaryDirectory();
      videoPath = path.join(directory.path, '${DateTime.now()}.mp4');
      await controller.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    }
  }

  Future<void> stopRecording() async {
    if (controller.value.isInitialized && controller.value.isRecordingVideo) {
      XFile video = await controller.stopVideoRecording();
      videoPath = video.path;
      setState(() {
        isRecording = false;
      });
    }
  }
  

  
  @override
  void dispose() {
      _videoPlayerController?.dispose();
    controller.dispose();
    super.dispose();
  }


VideoPlayerController? _videoPlayerController;

Future<void> uploadVideo(File 
  
  videoFile) async {
    if(isRecording){
      await stopRecording();
      isRecording = false;
      return;
    }
     isUploaded=true;
    setState(() {});
   // debugPrint("first");
    final uri = Uri.parse('${sultan}/upload');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile(
        'file',
        videoFile.readAsBytes().asStream(),
        videoFile.lengthSync(),
        filename: videoFile.path.split('/').last,
      ));
   // print("second");
    final response = await request.send();
  //  print(response.statusCode);

    if (response.statusCode == 200) {
       
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Success! Video uploaded!')));
      final uri = Uri.parse('${sultan}/finalAnswer');
      final newRequest = await http.get(uri);
      List<String> ll = newRequest.body.split(".");
      isUploaded=false;
    setState(() {});
      if(ll[0]=="false"){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
            height: 200,
            width: double.infinity,
            child: Column(
              children: [
                const Text("Correct your hips"),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("Close"))
              ],
            ),
          );
        });
      }
      else if (ll[1]=="false"){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
             width: double.infinity,
            height: 200,
            child: Column(
              
              children: [
                 Text("Correct your knees"),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("Close"))
              ],
            ),
          );
        });
      }
      else if (ll[2]=="false"){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
             width: double.infinity,
            height: 200,
            child: Column(
              
              children: [
                 Text("Correct your feet position"),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("Close"))
              ],
            ),
          );
        });
      }
      else{
        showModalBottomSheet(context: context, builder: (context){
          return Container(
             width: double.infinity,
            height: 200,
            child: Column(
              
              children: [
                 Text("Perfect kick. Well done!"),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("Close"))
              ],
            ),
          );
        });
      }


      // final responseBody = await response.stream.bytesToString();
      // setState(() {
      //   _videoPlayerController = VideoPlayerController.network(responseBody)
      //     ..initialize().then((_) {
      //       setState(() {});
      //       _videoPlayerController!.play();
      //     });
      // });
    } else {
       isUploaded=false;
    setState(() {});
      // Handle upload failure
    }
  }















  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Let\'s practise', textAlign: TextAlign.center,),
      ),
      body: Column(
        children: [
          if (isCameraInitialized)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,

              child: AspectRatio(
               // aspectRatio: controller.value.aspectRatio,
               aspectRatio: 5/8,
                child: CameraPreview(controller),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
            onPressed: changeSide, child: const Icon(Icons.flip_camera_ios)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !isUploaded? ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: isRecording? Colors.red: Colors.green, foregroundColor: Colors.white),

                onPressed: isRecording ? stopRecording : startRecording,
                child: Text(isRecording ? 'Stop recording' : 'Start recording'),
              ):CircularProgressIndicator(),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              if (videoPath != null)
                isUploaded? const SingleChildScrollView(): isRecording? SizedBox(): ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: isRecording?Colors.orange.withOpacity(0.1): Colors.orange, foregroundColor: Colors.white),
                  onPressed: () async {
                    await uploadVideo(File(videoPath!));
                  },
                  child: const Text('Send recording'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
