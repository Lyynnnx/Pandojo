import 'package:flutter/material.dart';
import 'package:sportolingo/dummy_data/taekwondo_data.dart';
import 'package:sportolingo/models/status_enum.dart';

class AllCoursesList extends StatefulWidget {
  const AllCoursesList({super.key});

  @override
  State<AllCoursesList> createState() => _AllCoursesListState();
}

class _AllCoursesListState extends State<AllCoursesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
            // Add your onPressed code here
          },
        ),
        title: const Text('Current courses:', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 900),
                  content: Text('Work in Progress :)'),
                ));
              },
              child: const CourseTile(
                title: 'Running',
                subtitle: 'Current days: 3',
              ),
            ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02), 
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 900),
                  content: Text('Work in Progress :)'),
                ));
              },
              child:const CourseTile(
                title: 'Push-ups',
                subtitle: 'Current days: 2',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CourseTile(
                title: 'Taekwondo',
                subtitle:
                    'Lesson: ${taekwondoCourse.where((x) => x.status != Status.Blocked).length}/${taekwondoCourse.length}',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02), 
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 900),
                  content: Text('Work in Progress :)'),
                ));
              },
              child:const CourseTile(
                title: 'Boxing',
                subtitle: 'Lesson: 7/7',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 900),
                  content: Text('Work in Progress :)'),
                ));
              },
              child: const Text('Add new courses',
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final String title;
  final String subtitle;

   const CourseTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
