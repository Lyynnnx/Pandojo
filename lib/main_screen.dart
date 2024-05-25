
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportolingo/challange_screen.dart';
import 'package:sportolingo/course_screen.dart';
import 'package:sportolingo/dummy_data/achievments.dart';
import 'package:sportolingo/dummy_data/friends_dummy.dart';
import 'package:sportolingo/providers/user_data_provider.dart';



class MainScreen extends ConsumerStatefulWidget {
  

  

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {

  int index=1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // photo = ref.read(userDataProvider.notifier).getPhoto();
      setState(() {});
    });
  }
  Widget? curScreen;
  Widget? curAppBar;


  @override
  Widget build(BuildContext context) {
    if(index==1){
      curScreen=SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
             
                  Stack(
                    children:[
                      (ref.read(userDataProvider).isLogin==false)?
                       CircleAvatar(
                      radius: 50,
                      foregroundImage: FileImage(ref.read(userDataProvider).photo),
                      
                    ):
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(ref.read(userDataProvider).photo.path),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 70, top: 70),
                      child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.check_circle, color: Colors.green),
                          
                        ),
                    ),]
                  ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  'Welcome, ${ref.watch(userDataProvider).email ?? ''}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  'Continue your journey and achieve your target!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(height: MediaQuery.of(context).size.height*0.35 , child: ListView.builder(
                 // shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                  return dummy_achievment[index];
                }, itemCount:dummy_achievment.length,),
                ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.02),
             const Text("Friends:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
             SizedBox( height:MediaQuery.of(context).size.height*0.3 , width:double.infinity,
             child: ListView.builder(


                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return dummyFriends[index];
                },
                itemCount: dummyFriends.length,
              ),),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // SizedBox(height: MediaQuery.of(context).size.height*0.35 , child: ListView.builder(
                  //   // shrinkWrap: true,
                  //   //physics: NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index){
                  //     return courses[index];
                  //   }, itemCount:courses.length,),
                  // ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Text(
                  //   'Часов Тренировок В Неделю:',
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  // ),
                ],
             
                // Text(
                //   'Часов Тренировок В Неделю:',
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
              
            ),
          ),
        ),
      );
    }
    else if (index==2){
      curScreen=const ChallangeScreen();
      curAppBar=AppBar(
        title: const Text("Challenges"),
      );

    }
    else{
      curScreen=const CourseScreen();
    }
      
    
    return Scaffold(
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.dumbbell),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.paw),
            label: 'Profile',
          ),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.trophy), label: 'Challenges')
        ],
      ),
      body: curScreen,
      
    );
  }
}



class TrainingData {
  final String date;
  final int hours;

  TrainingData(this.date, this.hours);
}