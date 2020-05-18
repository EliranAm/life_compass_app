import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/models/user_data.dart';
import 'package:lifecompassapp/services/location_handler.dart';
import 'package:lifecompassapp/screens/after_call_help_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCallHelpScreen extends StatelessWidget {
  static String id = 'login_call_help';
  final _firestore = Firestore.instance;

  Future<void> _callForHelp() async {
    // Get shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String callerName = prefs.getString(kNameSharedPrefKey);

    // Compose general message
    String message = await _composeMessage(prefs);

    // Add call to data base
    _addCallToDatabase(callerName, message);
  }

  Future<String> _composeMessage(SharedPreferences prefs) async {
    UserData userData = UserData();

    // Get user data
    userData.name = prefs.getString(kNameSharedPrefKey);
    userData.phone = prefs.getString(kPhoneSharedPrefKey);
    userData.address = prefs.getString(kAddressSharedPrefKey);
    userData.gender = prefs.getString(kGenderSharedPrefKey);
    userData.age = prefs.getString(kAgeSharedPrefKey);
    userData.relation = prefs.getString(kRelationSharedPrefKey);
    userData.notes = prefs.getString(kNotesSharedPrefKey);

    // Get user location from GPS
    String address = await LocationHandler.getAddress();
    print(address);
    // Compose message
    String message =
        '''${userData.name} הודיע/ה על מצב מצוקה כעת וזקוק לעזרתך. אנא פנה/י לרשויות לקריאה לעזרה בהקדם. כתובת רשומה: ${userData.address} מיקום נוכחי: $address''';
    print(message);
    print(message.length);
    return message;
  }

  void _addCallToDatabase(String callerName, String message) {
    _firestore.collection(kMainCollectionName).add({
      kCallerNameKey: callerName,
      kTimeStampKey: FieldValue.serverTimestamp(),
      kMessageKey: message,
    });
  }

  Future<bool> _showDialog(context) async {
    bool isTimeCompleted = true;
    var isApproved = await showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: kTimeToWait), () {
            if (isTimeCompleted) {
              Navigator.of(context).pop(true);
            }
          });
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: FittedBox(
                child: Column(
                  children: <Widget>[
                    Text(
                      'מתחבר לשרתים, אנא המתן...',
                    ),
                    SizedBox(height: 20.0,),
                    CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    isTimeCompleted = false;
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'ביטול',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                    ),
                  ),
                )
              ],
            ),
          );
        });

    return isApproved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: kLogoHeroTag,
                child: Container(
                  child: Image.asset(kLogoImage),
                  height: 200.0,
                ),
              ),
            ),
            Container(
              child: Text(
                'מצפן',
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () async {
                    bool isApproved = await _showDialog(context);
                    if (isApproved) {
                      _callForHelp();
                      Navigator.pushNamed(context, AfterCallHelpScreen.id);
                    } else {
                      print('canceled');
                    }
                  },
                  minWidth: 250.0,
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        FlutterIcons.md_log_in_ion,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'התחבר',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
