import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/models/call_for_help_model.dart';

class CallForHelpCard extends StatelessWidget {
  CallForHelpCard({@required this.call});

  final CallForHelpModel call;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              FlutterIcons.help_box_mco,
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
          subtitle: Text(
            call.message,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ),
    );
  }
}
