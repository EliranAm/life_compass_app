import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifecompassapp/components/custom_navigation_button.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/models/contact_info.dart';
import 'package:lifecompassapp/models/user_data.dart';
import 'package:lifecompassapp/screens/after_registration_screen.dart';
import 'package:lifecompassapp/services/location_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationGeneralInfo extends StatefulWidget {
  static String id = 'registration_general_info';

  @override
  _RegistrationGeneralInfoState createState() =>
      _RegistrationGeneralInfoState();
}

class _RegistrationGeneralInfoState extends State<RegistrationGeneralInfo> {
  UserData userData;

  Future<bool> _registerToSharedPref() async {
    bool result = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert contact list
    List<String> contactList = userData.contacts.map((ContactInfo contact) {
      return '${contact.fullName},${contact.phoneNumber}';
    }).toList();

    // Save all user data to shared preferences
    await prefs.setString(kNameSharedPrefKey, userData.name);
    await prefs.setString(kPhoneSharedPrefKey, userData.phone);
    await prefs.setString(kAddressSharedPrefKey, userData.address);
    await prefs.setString(kGenderSharedPrefKey, userData.gender);
    await prefs.setString(kAgeSharedPrefKey, userData.age);
    await prefs.setString(kRelationSharedPrefKey, userData.relation);
    await prefs.setString(kNotesSharedPrefKey, userData.notes);
    await prefs.setStringList(kContactsSharedPrefKey, contactList);
    await prefs.setBool(kIsHelperSharedPrefKey, false);
    result = await prefs.setBool(kRegisterSharedPrefKey, true);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('הרשמה'),
          actions: <Widget>[
            CustomNavigationButton(
              title: 'סיים',
              icon: Icons.done,
              onPressed: () async {
                // Call location just to get permissions to GPS
                String address = await LocationHandler.getAddress();
                print(address);

                // Register to shared preferences
                await _registerToSharedPref();

                // Navigate to next screen
                Navigator.pushNamed(context, AfterRegistrationScreen.id);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'מידע נוסף',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    gapPadding: 5.0,
                  ),
                  hintText:
                      'כאן תוכל/י לרשום מידע נוסף, למשל, מצב משפחתי, מספר ילדים, תדירות האירועים וכדומה',
                  labelText: 'הערות',
                ),
                onChanged: (newValue) {
                  userData.notes = newValue;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
