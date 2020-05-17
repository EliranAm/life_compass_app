import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/components/call_for_help_card.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/models/call_for_help_model.dart';

class HelperMainScreen extends StatelessWidget {
  static String id = 'helper_main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: kPrimaryColor,
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 20, right: 20, top: 30),
                title: Text(
                  'Full Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  '42625 points',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                trailing: CircleAvatar(
                  radius: 26,
                  child: Icon(
                    Icons.supervised_user_circle,
                    size: 40.0,
                  ),
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Container(
                child: ListView(
                  children: <Widget>[
                    CallForHelpCard(
                      call: CallForHelpModel(
                          callerName: 'פלונית אלמונית',
                          time: '16:10',
                          message:
                          'פלוית אלמונית צריכה עזרה, היא נמצאת בכתובת רחוב 10, עיר, ישראל. לפי מיקום GPS נמצאת ברחוב בלה בלה 122, עיר אחרת.'),
                    ),
                    CallForHelpCard(
                      call: CallForHelpModel(
                          callerName: 'פלונית אלמונית',
                          time: '16:20',
                          message:
                          'פלוית אלמונית צריכה עזרה, היא נמצאת בכתובת רחוב 10, עיר, ישראל. לפי מיקום GPS נמצאת ברחוב בלה בלה 122, עיר אחרת.'),
                    ),
                  ],
                ),
              ),
            ),
            flex: 5,
          ),
        ],
      ),
    );
  }
}
