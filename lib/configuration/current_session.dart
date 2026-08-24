import '../screens/auth/login/model/login_response.dart';
import '../screens/intro/model/intro_model.dart';

class CurrentSession {
  CurrentSession._private();

  static final CurrentSession _shared = CurrentSession._private();

  factory CurrentSession() => _shared;

  List<IntroModel> _intro = [];

  set intro(List<IntroModel> value) {
    _intro = value;
  }

  List<IntroModel> get intro => _intro;

  UserModel? _userModel;

  set userModel(UserModel? value) {
    _userModel = value;
  }

  UserModel? getUser() => _userModel;

  void clear() {
    _userModel = null;
  }
}
