import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifecompassapp/components/contact_form.dart';
import 'package:lifecompassapp/components/custom_navigation_button.dart';
import 'package:lifecompassapp/models/contact_info.dart';
import 'package:lifecompassapp/models/user_data.dart';
import 'package:lifecompassapp/screens/registartion/registration_general_info.dart';

class RegistrationContactsInfo extends StatefulWidget {
  static String id = 'registration_contacts_info';

  @override
  _RegistrationContactsInfoState createState() =>
      _RegistrationContactsInfoState();
}

class _RegistrationContactsInfoState extends State<RegistrationContactsInfo> {
  List<ContactForm> contacts = [];
  UserData userData;

  bool _isContactsValid() {
    bool result = true;

    for (var contact in contacts) {
      if (contact.isValid() == false) {
        result = false;
        break;
      }
    }

    return result;
  }

  void _setContactsData() {
    for (ContactForm contact in contacts) {
      print('adding');
      userData.contacts.add(contact.contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    if (userData == null) {
      userData = UserData();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('הרשמה'),
          actions: <Widget>[
            CustomNavigationButton(
              title: 'המשך',
              icon: Icons.arrow_forward,
              onPressed: () {
                if (_isContactsValid()) {
                  // Update user data
                  _setContactsData();

                  // Navigate to next screen
                  Navigator.pushNamed(context, RegistrationGeneralInfo.id,
                      arguments: userData);
                }
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: contacts.length <= 0
                    ? Center(
                        child: Container(
                          child: Text(
                            'רשימת אנשי קשר במקרה של קריאה לעזרה'
                            '\n\n'
                            'הוספה בעזרת לחיצה על הכפתור בתחתית העמוד',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 0.5,
                                color: Colors.black54),
                          ),
                        ),
                      )
                    : ListView.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: contacts.length,
                        itemBuilder: (_, i) => contacts[i],
                      ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: onAddForm,
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  ///on form user deleted
  void onDelete(ContactInfo _user) {
    setState(() {
      var find = contacts.firstWhere(
        (it) => it.contact == _user,
        orElse: () => null,
      );
      if (find != null) contacts.removeAt(contacts.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _contact = ContactInfo();
      contacts.add(ContactForm(
        contact: _contact,
        onDelete: () => onDelete(_contact),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (contacts.length > 0) {
      var allValid = true;
      contacts.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = contacts.map((it) => it.contact).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('List of Users'),
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text(data[i].fullName.substring(0, 1)),
                  ),
                  title: Text(data[i].fullName),
                  subtitle: Text(data[i].phoneNumber),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
