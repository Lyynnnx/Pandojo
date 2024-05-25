import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportolingo/login_screen.dart';
import 'package:sportolingo/main_screen.dart';
import 'package:sportolingo/models/sex_enum.dart';
import 'package:sportolingo/providers/user_data_provider.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final key = GlobalKey<FormState>();
  Color strictColor= Colors.blue;
  String email = '';
  String username = '';
  String password = '';
  String heigth = '';
  String weight = '';
  Sex sex = Sex.Diverse;
  // File photo = File('lib/media/panda2.png');
  File? photo;

  void signUp()async {
    if (key.currentState!.validate() && photo!=null) {
      if(await ref
          .read(userDataProvider.notifier)
          .signUp(email, username, password, heigth, weight, sex, photo!, context)){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
          }
           else{
      strictColor=Colors.red;
      setState(() {
        
      });
    }

      // Add your signUp code here
    
    }
    else{
      strictColor=Colors.red;
      setState(() {
        
      });
    }
  }

  void makePhoto()async{
    final value = await ImagePicker().pickImage(source: ImageSource.camera);
      if(value!=null){
        photo = File(value.path);
        setState(() {});
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'If you already have an account register',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Row(
                  children: [
                    const Text(
                      'You can ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                        // Add your onTap code here for login navigation
                      },
                      child: const Text(
                        'Login here !',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    email = value;
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    username = value;
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    password = value;
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value != password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
                    hintText: 'Enter your confirm password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    heigth = value;
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Your current height',
                    hintText: 'Enter your height',
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    weight = value;
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Your current weight',
                    hintText: 'Enter your weight',
                    prefixIcon: Icon(Icons.line_weight),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text('Your sex', style: TextStyle(fontSize: 16)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Column(
                  children: [
                    RadioListTile(
                      title: const Text('Male'),
                      value: Sex.Male,
                      groupValue: sex,
                      onChanged: (value) {
                        sex = value!;
                        setState(() {});
                      },
                    ),
                    RadioListTile(
                      title: const Text('Female'),
                      value: Sex.Female,
                      groupValue: sex,
                      onChanged: (value) {
                        //print("mama");
                        sex = value!;
                        setState(() {});
                        // Add your onChanged code here
                      },
                    ),
                    RadioListTile(
                      title: const Text('Diverse'),
                      value: Sex.Diverse,
                      groupValue: sex,
                      onChanged: (value) {
                        sex = value!;
                        setState(() {});
                        // Add your onChanged code here
                      },
                    ),
                    photo==null?
                      OutlinedButton(
                        
                        style: OutlinedButton.styleFrom(
                          
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    iconColor: strictColor, // text color
                    side:  BorderSide(
                        color: strictColor), // border color
                  ),  onPressed: () {
                      makePhoto();
                      // Add your onPressed code here
                    },
                    child: SizedBox(width:MediaQuery.of(context).size.width*0.5 ,child: const Icon(Icons.photo),),):
                    GestureDetector(onTap:(){makePhoto();}, child: Image.file(photo!,height: MediaQuery.of(context).size.height*0.3,width: MediaQuery.of(context).size.width*0.7,)),
                  
                        
                          
                        
                        
                  
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      signUp();
                      // Add your onPressed code here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      foregroundColor: Colors.blue, // background color
                      backgroundColor: Colors.white, // text color
                    ),
                    child:
                        const Text('Register', style: TextStyle(fontSize: 16)),
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
