import 'package:flutter/material.dart';
import 'package:lifecompassapp/models/contact_info.dart';
import 'package:lifecompassapp/services/fields_validator.dart';

class ContactForm extends StatefulWidget {
  final ContactInfo contact;
  final state = _ContactFormState();
  final Function onDelete;

  ContactForm({Key key, this.contact, this.onDelete}) : super(key: key);
  @override
  _ContactFormState createState() => state;

  bool isValid() => state.validate();
}

class _ContactFormState extends State<ContactForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('פרטי איש קשר'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  validator: (val) =>
                  FieldsValidator.isValidName(val) ? null : 'שם איש קשר לא תקין',
                  decoration: InputDecoration(
                    labelText: 'שם מלא',
                    hintText: 'הכנס/י שם מלא',
                    icon: Icon(Icons.person),
                    isDense: true,
                  ),
                  onChanged: (newValue) {
                    widget.contact.fullName = newValue;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  initialValue: widget.contact.phoneNumber,
                  onSaved: (val) => widget.contact.phoneNumber = val,
                  validator: (val) =>
                  FieldsValidator.isValidPhoneNumber(val) ? null : 'מספר טלפון לא תקין',
                  decoration: InputDecoration(
                    labelText: 'מספר טלפון',
                    hintText: 'הכנס/י מספר טלפון',
                    icon: Icon(Icons.phone),
                    isDense: true,
                  ),
                  onChanged: (newValue) {
                    widget.contact.phoneNumber = newValue;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    return form.currentState.validate();
  }
}