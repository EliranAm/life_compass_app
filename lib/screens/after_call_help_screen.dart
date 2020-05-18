import 'package:flutter/material.dart';
import 'package:lifecompassapp/constants.dart';

class AfterCallHelpScreen extends StatelessWidget {
  static String id = 'after_call_help';

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
              child: Column(
                children: <Widget>[
                  Text(
                    'ישנה בעיה בהתחברות לשרתים...',
                    style: TextStyle(fontSize: 24.0, color: Colors.black45),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'אנא נסו שוב מאוחר יותר',
                    style: TextStyle(fontSize: 24.0, color: Colors.black45),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
