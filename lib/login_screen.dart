import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportolingo/main_screen.dart';
import 'package:sportolingo/providers/reg_provider.dart';
import 'package:sportolingo/providers/user_data_provider.dart';
import 'package:sportolingo/sign_in.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String login ='';
  String password ='';
  bool rememberme = false;
  final key = GlobalKey<FormState>();
  void loginUser()async {
    if(key.currentState!.validate()){
      if(await ref.read(userDataProvider.notifier).login(login, password, context)){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
        
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Failed'),
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key:key,
            child: 
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  const Text(
                    'Log in',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  const Text(
                    'If you don’t have an account register',
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                          // Add your onTap code here for register navigation
                        },
                        child: const Text(
                          'Register here !',
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please enter your email';
                      }
                      else{
                        login = value;
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty ){
                        return 'Please enter your password';
                      }
                      else{
                        password = value;
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberme,
                            onChanged: (bool? value) {
                              rememberme = value!;
                              setState((){});
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Work in progress :D'),
                                ),
                              );
                              // Handle remember me functionality
                            },
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                           ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Work in progress :D'),
                                ),
                              );
                          // Add your onPressed code here for forgot password
                        },
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        loginUser();
              
                       
                        // Add your onPressed code here for login
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1, vertical: MediaQuery.of(context).size.height*0.02),
                        foregroundColor: Colors.blue, // background color
                        backgroundColor: Colors.white, // text color
                      ),
                      child: const Text('Login', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
