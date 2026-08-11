import 'package:scoped_model/scoped_model.dart';

import '../screens/auth/login/model/login_response.dart';
import '../screens/intro/model/intro_model.dart';

class CurrentSession extends Model {
  CurrentSession._();

  static final CurrentSession _shared = CurrentSession._();

  factory CurrentSession() => _shared;

  UserModel? userModel;

  UserModel? getUser() => userModel;

  List<IntroModel> _intro = [];

  List<IntroModel> get intro => _intro;

  set intro(List<IntroModel> value) {
    _intro = value;
    notifyListeners();
  }

  void clear() {
    userModel = null;
  }
}
