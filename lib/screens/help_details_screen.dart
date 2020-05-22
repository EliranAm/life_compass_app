import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifecompassapp/components/rounded_button.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/models/call_for_help_model.dart';
import 'package:lifecompassapp/services/date_time_handler.dart';

class HelpDetailsScreen extends StatelessWidget {
  HelpDetailsScreen({@required this.call, this.callDatabaseUid});

  static String id = 'help_details';

  final _firestore = Firestore.instance;
  final CallForHelpModel call;
  final String callDatabaseUid;

  Future<bool> _showDialog(context) async {
    var isApproved = await showDialog(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              content: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xFFFFFF),
                    borderRadius: BorderRadius.circular(130.0)),
                child: FittedBox(
                  child: Text(
                    'הקריאה תמחק כעת.' +
                        '\n' +
                        'האם את/ה בטוח/ה שטיפלת בקריאה?',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'ביטול',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'אישור',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        });

    return isApproved;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
          decoration: kRoundedTopEdges,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      call.callerName,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    DateTimeHandler.formatTimestamp(call.time.toDate()),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Text(
                  call.message,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                title: 'הגבתי לקריאה',
                color: kAccentColor,
                onPressed: () async {
                  bool isApproved = await _showDialog(context);
                  if (isApproved) {
                    _firestore
                        .collection(kMainCollectionName)
                        .document(callDatabaseUid)
                        .delete();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
