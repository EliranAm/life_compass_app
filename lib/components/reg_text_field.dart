
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hint,
          labelText: label,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}