import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifecompassapp/components/custom_navigation_button.dart';
import 'package:lifecompassapp/components/reg_dropdown.dart';
import 'package:lifecompassapp/components/reg_text_field.dart';
import 'package:lifecompassapp/models/user_data.dart';
import 'package:lifecompassapp/screens/registartion/registration_contacts_info.dart';
import 'package:lifecompassapp/services/fields_validator.dart';

class RegistrationPersonalDetails extends StatefulWidget {
  static String id = 'registarion_personal_details';

  @override
  _RegistrationPersonalDetailsState createState() =>
      _RegistrationPersonalDetailsState();
}

class _RegistrationPersonalDetailsState
    extends State<RegistrationPersonalDetails> {
  final _formKey = GlobalKey<FormState>();

  UserData userData;
  String _relation = 'בן/בת זוג';
  String _otherRelation;
  final _ageOptions = List<String>.generate(
    121,
        (int index) => index.toString(),
  );
  final _genderOptions = ['נקבה', 'זכר', 'אחר'];
  final _relationOptions = [
    'בן/בת זוג',
    'הורה',
    'אח/אחות',
    'קרוב משפחה',
    'אחר'
  ];

  bool _isOtherRelation() {
    return _relation == 'אחר';
  }

  @override
  void initState() {
    super.initState();

    userData = UserData();
    userData.age = '0';
    userData.gender = 'נקבה';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'הרשמה',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          actions: <Widget>[
            CustomNavigationButton(
              title: 'המשך',
              icon: Icons.arrow_forward,
              onPressed: () {
                if (_formKey.currentState.validate()) {

                  // Update user data
                  userData.relation =
                  _isOtherRelation() ? _otherRelation : _relation;

                  // Navigate to next screen
                  Navigator.pushNamed(
                    context, RegistrationContactsInfo.id, arguments: userData,);
                }
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'פרטים אישיים',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              RegTextField(
                icon: Icons.person,
                hint: 'הכנס/י שם מלא',
                label: 'שם',
                validator: (val) =>
                FieldsValidator.isValidName(val) ? null : 'אנא הכנס/י שם מלא',
                onChanged: (newValue) {
                  userData.name = newValue;
                },
              ),
              RegTextField(
                icon: Icons.phone,
                hint: 'הכנס/י מספר טלפון',
                label: 'מספר טלפון',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                validator: (value) =>
                FieldsValidator.isValidPhoneNumber(value)
                    ? null
                    : 'אנא הכנס/י מספר טלפון תקין',
                onChanged: (newValue) {
                  userData.phone = newValue;
                },
              ),
              RegTextField(
                icon: Icons.home,
                hint: 'הכנס/י כתובת מלאה',
                label: 'כתובת',
                validator: (val) => val.isEmpty ? 'אנא הכנס/י כתבות מלאה' : null,
                onChanged: (newValue) {
                  userData.address = newValue;
                },
              ),
              RegDropdown(
                title: 'מין',
                items: _genderOptions,
                selectItem: userData.gender,
                onChanged: (String selectedGender) {
                  setState(() {
                    userData.gender = selectedGender;
                  });
                },
              ),
              RegDropdown(
                title: 'גיל',
                items: _ageOptions,
                selectItem: userData.age,
                onChanged: (String selectedAge) {
                  setState(() {
                    userData.age = selectedAge;
                  });
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 60.0),
                child: Text(
                  'מהו הקשר אל האדם ממנו החשש?',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              RegDropdown(
                items: _relationOptions,
                selectItem: _relation,
                onChanged: (String selectedRelation) {
                  setState(() {
                    _relation = selectedRelation;
                  });
                },
              ),
              Visibility(
                visible: _isOtherRelation(),
                child: RegTextField(
                  hint: 'הכנס/י כתובת מלאה',
                  label: 'פרט/י כאן את הקשר',
                  onChanged: (newValue) {
                    _otherRelation = newValue;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

