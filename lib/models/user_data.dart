import 'dart:io';

import 'package:sportolingo/models/sex_enum.dart';

class UserData{
  const UserData({
    required this.email,
    required this.username,
    required this.password,
    required this.heigth,
    required this.weight,
    required this.sex,
    required this.photo,
    required this.isLogin});
  final String email;
  final String username;
  final String password;
  final String heigth;
  final String weight;
  final Sex sex;
  final File photo;
  final bool isLogin;
  
}