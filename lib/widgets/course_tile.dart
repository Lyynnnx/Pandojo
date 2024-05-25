import 'package:flutter/material.dart';
import 'package:sportolingo/achievment_info.dart';

class CourseTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String text;

  const CourseTile({super.key, required this.title, required this.subtitle, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AchievmentInfo(title: title, info: text, image: image)));
      
      },
      // leading: CircleAvatar(
      //   backgroundImage: AssetImage(image),
      // ),
      leading: Image.asset(image),
      
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
}