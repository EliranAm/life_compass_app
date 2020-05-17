import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifecompassapp/components/reg_text_field.dart';
import 'package:lifecompassapp/components/rounded_button.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/screens/helper_main_screen.dart';
import 'package:lifecompassapp/services/fields_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperRegistrationScreen extends StatefulWidget {
  static String id = 'helper_registration';

  @override
  _HelperRegistrationScreenState createState() =>
      _HelperRegistrationScreenState();
}

class _HelperRegistrationScreenState extends State<HelperRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String userName;
  String email;
  String password;

  Future<void> _registerToDatabase() async {
    try {
      // Send create user request
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Check if user created
      if (newUser != null) {
        await newUser.user.updateProfile(
          UserUpdateInfo()..displayName = userName,
        );
        print('Registered');
        Navigator.pushNamed(context, HelperMainScreen.id);
      }
    } catch (ex) {
      String error = '';
      if (ex is PlatformException) {
        if (ex.code == 'ERROR_WEAK_PASSWORD') {
          error = 'Password is too weak';
        } else {
          error = 'Email already exist';
        }
      }

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Can not Register"),
                content: Text(error),
              ));
      print("Error: " + ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'מצפן',
                      style: TextStyle(
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'הכנס/י שם משתמש',
                      hintText: 'שם',
                    ),
                    validator: (val) => val.length > 0
                        ? null
                        : 'אנא הכנס/י שם מלא',
                    onChanged: (newValue) {
                      userName = newValue;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'הכנס/י מייל',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'הכנס/י סיסמה',
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'הירשם',
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        // Show loading spinner
                        setState(() {
                          showSpinner = true;
                        });

                        // Register to database
                        await _registerToDatabase();

                        // Set shared preferences
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool(kIsHelperSharedPrefKey, true);
                        await prefs.setBool(kRegisterSharedPrefKey, true);

                        // Hide Spinner
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
