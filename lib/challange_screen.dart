import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallangeScreen extends StatefulWidget {
  const ChallangeScreen({super.key});

  @override
  State<ChallangeScreen> createState() => _ChallangeScreenState();
}

class _ChallangeScreenState extends State<ChallangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Challenges"),
        leading: const SizedBox(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Work in progress"),
                    ),
                  );
                  // Navigator.pushNamed(context, '/course_screen');
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('lib/media/ring.jpg'),
                      fit: BoxFit.cover,
                    ),
                    
                    shape: BoxShape.rectangle,
                    // gradient: const LinearGradient(
                    //   colors: [Colors.red, Colors.yellow],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'lib/media/tyson.png',
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          Row(
                            children: [
                              SizedBox(child: SizedBox(width: MediaQuery.of(context).size.width*0.3,),),
                              Column(
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height*0.131),
                                  Text(
                                  
                                    "Train with \nPanda Tyson",
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.bungee(fontSize: 15, color: Color.fromARGB(255, 168, 3, 3), 
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      //   Expanded(
                      //   child: 
                      
                      //       Text(

                      //       "Current month challenge",
                      //       softWrap: true,
                      //       overflow: TextOverflow.clip,
                      //       textAlign: TextAlign.center,
                      //       style: GoogleFonts.bungee(fontSize: 15, color: Color.fromARGB(255, 168, 3, 3), 
                      //       ),
                      //     ),
                        
                      // ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Work in progress"),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('lib/media/ring2.jpg'),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.rectangle,
                    // gradient: const LinearGradient(
                    //   colors: [Color.fromARGB(255, 255, 221, 0), Color.fromARGB(255, 30, 239, 3)],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      
                      Text("Challenge your friends",
                          style: GoogleFonts.bungee( fontSize: 15, color: Colors.white, 
                          ),
                          
                          ),
                          
                          Image.asset("lib/media/twoPandas.png", height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.4),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
