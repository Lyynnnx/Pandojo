import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sportolingo/linkChange.dart';
import 'package:video_player/video_player.dart';

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  File? _videoFile;
  VideoPlayerController? _videoPlayerController;
  final ImagePicker _picker = ImagePicker();
  bool isUploaded=false;

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });

      await _uploadVideo(_videoFile!);
    }
  }

  Future<void> _uploadVideo(File 
  
  videoFile) async {
    //debugPrint("first");https://764f-95-130-161-159.ngrok-free.app
    isUploaded=true;
    setState(() {});
    final uri = Uri.parse('${sultan}/upload');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile(
        'file',
        videoFile.readAsBytes().asStream(),
        videoFile.lengthSync(),
        filename: videoFile.path.split('/').last,
      ));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      setState(() {
        _videoPlayerController = VideoPlayerController.network(responseBody)
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController!.play();
          });
      });
    } else {
       isUploaded=false;
    setState(() {});
      // Handle upload failure
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload and Showcase Video'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_videoFile != null)
              _videoPlayerController != null && _videoPlayerController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController!),
                    )
                  : const CircularProgressIndicator()
            else
              const Text('No video selected.'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Pick Video'),
            ),
          ],
        ),
      ),
    );
  }
}