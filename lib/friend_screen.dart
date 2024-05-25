import 'package:flutter/material.dart';
import 'package:sportolingo/widgets/course_tile.dart';


class FriendScreen extends StatelessWidget {
   FriendScreen({super.key, required this.name, required this.imageUrl, required this.courses});
   String name;
    String imageUrl;
     List<CourseTile> courses;
    //List<CourseTile> courses=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
      body: Center(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                 
                      Stack(
                        children:[
                          
                           CircleAvatar(
                          radius: 50,
                          foregroundImage: AssetImage(imageUrl),
                          
                        ),
                        
                        const Padding(
                          padding: const EdgeInsets.only(left: 70, top: 70),
                          child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.check_circle, color: Colors.green),
                              
                            ),
                        ),]
                      ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      '${name}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    // const Text(
                    //   'Continue Your Journey And Achieve Your Target',
                    //   style: TextStyle(fontSize: 16, color: Colors.grey),
                    // ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(height: MediaQuery.of(context).size.height*0.35 , child: ListView.builder(
                     // shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                      return courses[index];
                    }, itemCount:courses.length,),
                    ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                 
                    // Text(
                    //   'Часов Тренировок В Неделю:',
                    //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}