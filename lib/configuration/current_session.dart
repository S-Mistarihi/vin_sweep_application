import 'package:vin_sweep_application/features/home/tabs/menu/contact_us/model/contact_info_model.dart';

import '../features/auth/login/model/login_response.dart';
import '../features/intro/model/intro_model.dart';

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

  ContactInfoModel? infoModel;
}
