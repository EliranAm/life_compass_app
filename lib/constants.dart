
import 'package:flutter/material.dart';

const kMaxDigitsInPhoneNumber = 10;
const kTimeToWait = 7;

// database keys
const kMainCollectionName = 'helps_calls';
const kCallerNameKey = 'caller';
const kTimeStampKey = 'time';
const kMessageKey = 'message';

const kNameSharedPrefKey = 'name';
const kPhoneSharedPrefKey = 'phone';
const kAddressSharedPrefKey = 'address';
const kGenderSharedPrefKey = 'gander';
const kAgeSharedPrefKey = 'age';
const kRelationSharedPrefKey = 'relation_with_abuser';
const kNotesSharedPrefKey = 'notes';
const kContactsSharedPrefKey = 'contacts';
const kRegisterSharedPrefKey = 'is_registered';
const kIsHelperSharedPrefKey = 'is_helper';

const kPrimaryColor = Color(0xff26A69A);
const kAccentColor = Color(0xffCC9900);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);
