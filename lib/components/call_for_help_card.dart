import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/models/call_for_help_model.dart';

class CallForHelpCard extends StatelessWidget {
  CallForHelpCard({@required this.call});

  final CallForHelpModel call;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          FlutterIcons.user_md_faw,
          color: Colors.white,
        ),
      ),
      title: Row(
        children: <Widget>[
          Text(call.callerName),
          SizedBox(
            width: 16.0,
          ),
          Text(
            call.time,
          ),
        ],
      ),
      subtitle: Text(call.message),
      trailing: Icon(
        Icons.arrow_forward_ios,
      ),
    );
  }
}
