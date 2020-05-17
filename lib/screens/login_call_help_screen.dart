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

  Future<void> _callForHelp() async {
    // Get shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get list of contacts
    List<String> contacts = prefs.getStringList(kContactsSharedPrefKey);

    // Compose general message
    String message = await _composeMessage(prefs);

    // TODO: Send notification to helpers

  }

  /*
  Future<void> _sendSMS(String message, List<String> recipients) async {
    List<String> phoneNumbers = [];

    // Collect all phone numbers
    for (var recipient in recipients) {
      List<String> info = recipient.split(',');
      if (info.length == 2) {
        phoneNumbers.add(info[1]);
      }
    }

    // Sens SMS to phone numbers
    if (phoneNumbers.length > 0) {
      String _result = await sendSMS(message: message, recipients: phoneNumbers)
          .catchError((onError) {
        print(onError);
      });
      print(_result);
    }
  }
  */

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

    // Compose message
    String message =
        '''${userData.name} הודיע/ה על מצב מצוקה כעת וזקוק לעזרתך. אנא פנה/י לרשויות לקריאה לעזרה בהקדם. כתובת רשומה: ${userData.address} מיקום נוכחי: $address''';
    print(message);
    print(message.length);
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
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
                    // TODO: popup box with time to cancel the call for help
                    _callForHelp();
                    Navigator.pushNamed(context, AfterCallHelpScreen.id);
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
