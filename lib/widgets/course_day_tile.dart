import 'package:flutter/material.dart';
import 'package:sportolingo/models/status_enum.dart';
import 'package:sportolingo/upload_video.dart';
import 'package:sportolingo/video_screen.dart';
import 'package:sportolingo/video_shower.dart';

class CourseDayTile extends StatelessWidget {
  final String day;
  final String title;
  final Status status;

  CourseDayTile({super.key, required this.day, required this.title, required this.status});
  Icon icon=const Icon(Icons.block, color: Colors.blue,);

  @override
  Widget build(BuildContext context) {
    if(status==Status.Done){
      icon=const Icon(Icons.check, color: Colors.blue,);}
    else if(status==Status.Now){
      icon=const Icon(Icons.star, color: Colors.blue,);}
    else {
      icon=const Icon(Icons.block, color: Colors.blue,);}
   
    return GestureDetector(
      onTap:(){
          if(status!=Status.Blocked){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideScreen
             ()));
          }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
           icon
          ],
        ),
      ),
    );
  }
}