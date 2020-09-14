import 'package:flutter/cupertino.dart';
import 'package:food_notifier/db_helper.dart';
import 'package:food_notifier/unit/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  static const String KEY_IS_LOGIN = "IS_LOGIN";
  static const String KEY_USER_ID = "USER_ID";

  User _me;
  bool _isLogin;

  Future<void> setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool(KEY_IS_LOGIN) ?? false;

    if(_isLogin) {
      String uid = prefs.getString(KEY_USER_ID);
      if(uid == null) {
        prefs.setBool(KEY_IS_LOGIN, false);
      } else {
        User user = await DBHelper.getUser(uid);
        
        if(user == null) {
          prefs.setBool(KEY_IS_LOGIN, false);
        } else {
          _me = user;
        }
      }
    }
  }

  bool get isLogin => _isLogin;

  void setLogin(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(KEY_IS_LOGIN, true);
    prefs.setString(KEY_USER_ID, id);
  }

  User get me => _me;

  set me(User value) {
    _me = value;
    notifyListeners();
  }

  Future<String> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_ID);
  }
}