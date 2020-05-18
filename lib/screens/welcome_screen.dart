import 'package:flutter/material.dart';
import 'package:lifecompassapp/components/rounded_button.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/screens/helper_registration.dart';
import 'package:lifecompassapp/screens/registartion/registarion_personal_details.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            SizedBox(height: 20.0,),
            Container(
              alignment: Alignment.center,
              child: Text(
                'מצפן',
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
            ),
            SizedBox(height: 50.0,),
            RoundedButton(
              title: 'זקוק/ה לעזרה',
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationPersonalDetails.id);
              },
            ),
            RoundedButton(
              title: 'מוכן/ה לעזור',
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pushNamed(context, HelperRegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
