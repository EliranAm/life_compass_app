import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/models/call_for_help_model.dart';
import 'package:lifecompassapp/services/date_time_handler.dart';

class CallForHelpCard extends StatelessWidget {
  CallForHelpCard({@required this.call, this.onTap});

  final CallForHelpModel call;
  final Function onTap;

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
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              FlutterIcons.ios_notifications_ion,
              color: Colors.white,
            ),
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(call.callerName),
              ),
              SizedBox(
                width: 16.0,
              ),
              Text(
                DateTimeHandler.formatTimestamp(call.time.toDate()),
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
