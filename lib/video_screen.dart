import 'package:flutter/material.dart';
import 'package:sportolingo/practise_screen.dart';
import 'package:sportolingo/record_screen.dart';
import 'package:sportolingo/video_shower.dart';

class VideScreen extends StatefulWidget {
  const VideScreen({super.key});

  @override
  State<VideScreen> createState() => _VideScreenState();
}

class _VideScreenState extends State<VideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lesson 1"),),
      body: Column(
        children: [
          SizedBox(height:MediaQuery.of(context).size.height*0.02,),
          const MyVideoPlayer(),
          SizedBox(height:MediaQuery.of(context).size.height*0.02,),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white ),
            onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoRecorderScreen()));
          }, child: const Text("Try yourself!"))
        ],
      ),
    );
  }
}