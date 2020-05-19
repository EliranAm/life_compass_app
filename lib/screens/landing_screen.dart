import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/screens/helper_main_screen.dart';
import 'package:lifecompassapp/screens/login_call_help_screen.dart';
import 'package:lifecompassapp/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  static String id = 'landing';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _isRegister = true;
  bool _isHelper = false;
  Widget _content = Scaffold(
    body: Center(
      child: Text(
        kLogoTitle,
        style: TextStyle(
          fontSize: 50.0,
        ),
      ),
    ),
  );

  Future<void> _updateUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegister = prefs.getBool(kRegisterSharedPrefKey) ?? false;
    bool isHelper = prefs.getBool(kIsHelperSharedPrefKey) ?? false;
    setState(() {
      _isRegister = isRegister;
      _isHelper = isHelper;
    });
  }

  void _setScreenContent() async {
    // TODO: remove debug section
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setBool(kIsHelperSharedPrefKey, false);
//    await prefs.setBool(kRegisterSharedPrefKey, false);
    // end debug

    setState(() {
      if (_isRegister) {
        if (_isHelper) {
          _content = HelperMainScreen();
        } else {
          // if not helper
          _content = LoginCallHelpScreen();
        }
      } else {
        _content = WelcomeScreen();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    _setScreenContent();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: _content,
    );
  }
}
