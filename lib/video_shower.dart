import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:sportolingo/linkChange.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  // void pause(){
  //   _MyVideoPlayerState().pause();
  // }
  const MyVideoPlayer({super.key});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  bool isInitialised=false;
  late FlickManager flickManager;
  @override
  void initState(){
    super.initState();
    File videoFile = File("lib/media/banana.mp4");
    //  flickManager= FlickManager(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")));
     flickManager= FlickManager(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse("${sultan}""/taekwando")));
    // flickManager = FlickManager(
    //     videoPlayerController: VideoPlayerController.file(videoFile));
        setState(() {
        isInitialised = true;
      });
        
        
  }

   @override
  void dispose() {
    if (isInitialised) {
      flickManager.dispose();
    }
    super.dispose();
  }


  // void pause(){
  //   flickManager.flickVideoManager!.videoPlayerController!.pause();
  // }
  @override
  Widget build(BuildContext context) {
    return  SizedBox(width: MediaQuery.of(context).size.width*2, 
    height: MediaQuery.of(context).size.height*0.3, 
    child : FlickVideoPlayer(flickManager: flickManager, wakelockEnabled: false, wakelockEnabledFullscreen: false,));
  }
}
