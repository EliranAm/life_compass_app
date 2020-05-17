import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/screens/after_registration_screen.dart';
import 'package:lifecompassapp/screens/helper_main_screen.dart';
import 'package:lifecompassapp/screens/helper_registration.dart';
import 'package:lifecompassapp/screens/registartion/registration_contacts_info.dart';
import 'package:lifecompassapp/screens/landing_screen.dart';
import 'package:lifecompassapp/screens/after_call_help_screen.dart';
import 'package:lifecompassapp/screens/registartion/registration_general_info.dart';
import 'package:lifecompassapp/screens/registartion/registarion_personal_details.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.heebo().fontFamily,
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: LandingScreen.id,
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        RegistrationPersonalDetails.id: (context) => RegistrationPersonalDetails(),
        RegistrationContactsInfo.id: (context) => RegistrationContactsInfo(),
        RegistrationGeneralInfo.id: (context) => RegistrationGeneralInfo(),
        AfterRegistrationScreen.id: (context) => AfterRegistrationScreen(),
        AfterCallHelpScreen.id: (context) => AfterCallHelpScreen(),
        HelperRegistrationScreen.id: (context) => HelperRegistrationScreen(),
        HelperMainScreen.id: (context) => HelperMainScreen(),
      },
    );
  }
}
