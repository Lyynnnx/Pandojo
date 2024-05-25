import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportolingo/welcome_screen.dart';


void main() {
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
         textTheme:
           GoogleFonts.geologicaTextTheme(),
          //GoogleFonts.mondaTextTheme(),
      //    TextTheme(bodyLarge:TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //     bodyMedium: TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //     bodySmall:TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //     headlineLarge: TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //     headlineMedium: TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //     headlineSmall: TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //    displayLarge: TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //     displayMedium: TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //     displaySmall: TextStyle(fontSize: 20, fontFamily: 'Roboto' , color: Colors.black),
      //  ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
     // home: HomePage(),
     home: const HomePage(),

    );
  }















  
}

