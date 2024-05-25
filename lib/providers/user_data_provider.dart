import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportolingo/linkChange.dart';
import 'package:sportolingo/models/sex_enum.dart';
import 'package:sportolingo/models/user_data.dart';
import 'package:http/http.dart' as http;

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier()
      : super(UserData(
            email: '',
            username: '',
            password: '',
            heigth: '',
            weight: '',
            sex: Sex.Diverse,
            photo: File(''),
            isLogin: false));

  Future<bool> signUp(String email, String username, String password, String heigth,
      String weight, Sex sex, File photo, BuildContext context)async {
    state = UserData(
        email: email,
        username: username,
        password: password,
        heigth: heigth,
        weight: weight,
        sex: sex,
        photo: photo,
        isLogin: false);
    final uri = Uri.parse('${sultan}/register');
    final request = await http.post(uri,
        body: json.encode({
          email: password,
        }),
        headers: {'Content-Type': 'application/json'});
        if(request.statusCode ==228 || request.statusCode == 420){
         // print("хуй");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This email is already taken'),
            ),
          );
          return false;
        }
        else{
          //kprint("норм");
          return true;
        }
       // final filtered = json.decode(request.body);
        //print(filtered);
    // print("@");
    // print(state.email);
    // print(state.username);
    // print(state.password);
    // print(state.heigth);
    // print(state.weight);
    // print(state.sex.toString());
  }

  Future<bool> login(String email, String password, BuildContext context)async {
   // 228 - нету emeal
   // 600 - не сходится/
   //   print("login");
      state = UserData(
          email: email,
          username: '',
          password: password,
          heigth: '',
          weight: '',
          sex: Sex.Diverse,
          photo: File('lib/media/panda1.png'),
          isLogin: true);
      
      final uri = Uri.parse('${sultan}/login');
    final request = await http.post(uri,
        body: json.encode({
          email: password,
        }),
        headers: {'Content-Type': 'application/json'});
          if(request.statusCode ==228){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Somethin went wrong'),
              ),
            );
            return false;
          }
          else if (request.statusCode == 600){
          //  print("600");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password is incorrect'),
              ),
            );
            return false;
          }
          else if (request.statusCode == 420){
           // print("420");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('This email is not registered'),
              ),
            );
            return false;
          }
          else{
            return true;
          }
         // final filtered = json.decode(request.body);
          //print(filtered);

      return true;
    
    
  }
  // File getPhoto(){
  //  print("@@@");
  //   return state.photo;
  // }
}

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserData>(
    (ref) => UserDataNotifier());
