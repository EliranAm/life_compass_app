import 'package:flutter/material.dart';

class CustomNavigationButton extends StatelessWidget {
  CustomNavigationButton({
    @required this.title,
    @required this.icon,
    @required this.onPressed,
  });

  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
