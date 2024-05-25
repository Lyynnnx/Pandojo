import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationNotifier extends StateNotifier<bool> {
  RegistrationNotifier() : super(false);

  void signUp(String email, String password) {
    state = true;
  }


  
}
final registrationProvider = StateNotifierProvider<RegistrationNotifier, bool>((ref) => RegistrationNotifier());


class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier() : super(false);

  bool login(String email, String username) {
    state = true;
    return true;
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, bool>((ref) => LoginNotifier());