import '../screens/auth/login/model/login_response.dart';

class CurrentSession {
  CurrentSession._();

  static final CurrentSession _shared = CurrentSession._();

  factory CurrentSession() => _shared;

  UserModel? userModel;

  UserModel? getUser() => userModel;

  void clear() {
    userModel = null;
  }
}
