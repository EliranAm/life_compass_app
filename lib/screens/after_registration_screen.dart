import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AfterRegistrationScreen extends StatelessWidget {
  static String id = 'after_registration';

  Future<void> _printSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(kNameSharedPrefKey));
    print(prefs.getString(kPhoneSharedPrefKey));
    print(prefs.getString(kAddressSharedPrefKey));
    print(prefs.getString(kGenderSharedPrefKey));
    print(prefs.getString(kAgeSharedPrefKey));
    print(prefs.getString(kRelationSharedPrefKey));
    print(prefs.getString(kNotesSharedPrefKey));
    print(prefs.getStringList(kContactsSharedPrefKey));
    print(prefs.getBool(kRegisterSharedPrefKey));
  }

  void _closeApp(){
    _printSharedPref();
    print('Close App!');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _closeApp();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  child: Text(
                    'ההרשמה הסתיימה!',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'בפעם הבאה שתכנס/י לאפליקציה, תוכל/י לקרוא לעזרה בעזרת לחיצה על כפתור "התחבר". ',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      'בלחיצה על התחבר, תהיה את האופציה לבטל בתוך מספר שניות, במידה וכפתור הביטול לא ילחץ, תשלח הקריאה לעזרה!',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'לכל שאלה, בעיה או חשש, אנא, אל תהסס/י ופנה/י לגורמים המתאימים.',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _closeApp();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'יציאה',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(FlutterIcons.md_exit_ion),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
