
import 'package:flutter/material.dart';
import 'package:lifecompassapp/constants.dart';

class RegTextField extends StatelessWidget {
  const RegTextField({
    @required this.label,
    @required this.hint,
    this.icon,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  final String label;
  final String hint;
  final IconData icon;
  final Function onChanged;
  final keyboardType;
  final inputFormatters;
  final validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: TextFormField(
        onChanged: onChanged,
        decoration: kTextFieldDecoration.copyWith(
          labelText: label,
          icon: Icon(icon),
          hintText: hint,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}
