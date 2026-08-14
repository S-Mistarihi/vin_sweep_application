import '../screens/auth/login/model/login_response.dart';
import '../screens/intro/model/intro_model.dart';

class CurrentSession {
  CurrentSession._();

  static final CurrentSession _shared = CurrentSession._();

  factory CurrentSession() => _shared;

  List<IntroModel> _intro = [];

  set intro(List<IntroModel> value) {
    _intro = value;
  }

  List<IntroModel> get intro => _intro;

  UserModel? userModel;

  UserModel? getUser() => userModel;

  void clear() {
    userModel = null;
  }
}
