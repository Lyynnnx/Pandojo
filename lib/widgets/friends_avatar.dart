import 'package:flutter/material.dart';
import 'package:sportolingo/friend_screen.dart';
import 'package:sportolingo/widgets/course_tile.dart';

class FriendsAvatar extends StatelessWidget {
   FriendsAvatar({super.key, required this.name, required this.imageurl, required this.courses});
  String name;
  String imageurl;
  List<CourseTile> courses = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 1,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FriendScreen(name: name, imageUrl: imageurl, courses: courses,)));
        },
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage:  AssetImage(imageurl),
              radius: MediaQuery.of(context).size.width * 0.1,
            ),
            Text(name, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2, softWrap: true,),
          ],
        ),
      ),);
  }
}