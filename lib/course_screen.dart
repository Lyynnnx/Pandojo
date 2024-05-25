import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportolingo/all_courses_list.dart';
import 'package:sportolingo/dummy_data/taekwondo_data.dart';
import 'package:sportolingo/providers/hp_streak_provider.dart';

class CourseScreen extends ConsumerStatefulWidget {
  const CourseScreen({super.key});

  @override
  ConsumerState<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends ConsumerState<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: SizedBox(),
        title: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
              
               ElevatedButton(onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AllCoursesList()));
               },
               child: const Text(
                'Show my courses',
                
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.blue, fontSize: 12, fontStyle: FontStyle.italic),)),
                
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.black),
                onPressed: () {
                  // Add your onPressed code here
                },
              ),
                Text(ref.read(hpStreakProvider.notifier).state.hp.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
              IconButton(
                icon:const  Icon(Icons.whatshot, color: Colors.black),
                onPressed: () {
                  // Add your onPressed code here
                },
              ),
              Text(ref.read(hpStreakProvider.notifier).state.streak.toString(),
                  textAlign: TextAlign.center,
                  style:const TextStyle(color: Colors.black, fontSize: 12)),
              // IconButton(
              //   icon: Icon(Icons.add_circle_outline, color: Colors.black),
              //   onPressed: () {
              //     // Add your onPressed code here
              //   },
              // ),
              // Text(ref.read(hpStreakProvider.notifier).state.coins.toString(),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(color: Colors.black, fontSize: 15)),
            ]),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Text(
                    'Current course:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                   Text(
                    'Taekwondo',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(itemBuilder: (context, index){
                return taekwondoCourse[index];
              },
              itemCount: taekwondoCourse.length,),
            ),
          ],
        ),
      ),
    
    );
  }
}


