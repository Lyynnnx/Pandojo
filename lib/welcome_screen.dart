import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportolingo/login_screen.dart';
import 'package:sportolingo/sign_in.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    //double cringe =MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/media/panda1.png', height: MediaQuery.of(context).size.height * 0.42, width: MediaQuery.of(context).size.width * 0.42,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const Text(
                  'Welcome to',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Pandojo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text(
                  'Let\'s change your life together!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),



                ElevatedButton(
                  
                  
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                    // Add your onPressed code here!
                  },
                  style: ElevatedButton.styleFrom(
                    
                    
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    iconColor: Colors.blue,
                  ),
                  child: SizedBox(width: MediaQuery.of(context).size.width * 0.5,
                    child: const Text('Let\'s start!',textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),



                SizedBox(height: MediaQuery.of(context).size.height * 0.01),



                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
                    // Add your onPressed code here!
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    iconColor: Colors.blue, // text color
                    side: const BorderSide(
                        color: Colors.blue, width: 3.0), // border color
                  ),
                  child: SizedBox(width: MediaQuery.of(context).size.width * 0.5,
                    child: const Text('I\'m new here', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.blue)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
