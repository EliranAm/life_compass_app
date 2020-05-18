import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/models/call_for_help_model.dart';

class CallForHelpCard extends StatelessWidget {
  CallForHelpCard({@required this.call, this.onTap});

  final CallForHelpModel call;
  final Function onTap;

  String _formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return '${date.hour}:${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              FlutterIcons.ios_notifications_ion,
              color: Colors.white,
            ),
          ),
          title: Row(
            children: <Widget>[
              Expanded(child: Text(call.callerName)),
              SizedBox(
                width: 16.0,
              ),
              Text(
                _formatTimestamp(call.time),
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
