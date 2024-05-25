import 'package:flutter/material.dart';

class AchievmentInfo extends StatefulWidget {
  final String title;
  final String info;
  final String image;

  const AchievmentInfo({
    super.key,
    required this.title,
    required this.info,
    required this.image,
  });

  @override
  State<AchievmentInfo> createState() => _AchievmentInfoState();
}

class _AchievmentInfoState extends State<AchievmentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            // CircleAvatar(
            //   backgroundImage: AssetImage(widget.image),
            //   radius: 100,
            // ),
            Image.asset(widget.image, width: MediaQuery.of(context).size.width*0.45, height: MediaQuery.of(context).size.height*0.45),
            Text(widget.title, style: const TextStyle(fontSize: 24)),
            Text(widget.info),
          ],
        ),
      ),
    );
  }
}
