import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/components/call_for_help_card.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/models/call_for_help_model.dart';

final _firestore = Firestore.instance;
FirebaseUser currentUser;

class HelperMainScreen extends StatefulWidget {
  static String id = 'helper_main';

  @override
  _HelperMainScreenState createState() => _HelperMainScreenState();
}

class _HelperMainScreenState extends State<HelperMainScreen> {
  final _auth = FirebaseAuth.instance;

  void setCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          currentUser = user;
        });
      }
    } catch (ex) {
      print("Error: " + ex.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: kPrimaryColor,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  title: Text(
                    currentUser != null && currentUser.displayName != null
                        ? currentUser.displayName
                        : '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                  trailing: CircleAvatar(
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.white,
                    radius: 26,
                    child: Icon(
                      FlutterIcons.user_circle_faw,
                      size: 40.0,
                    ),
                  ),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      CallForHelpCard(
                        call: CallForHelpModel(
                            callerName: 'פלונית אלמונית',
                            time: '16:10',
                            message:
                                'פלוית אלמונית צריכה עזרה, היא נמצאת בכתובת רחוב 10, עיר, ישראל. לפי מיקום GPS נמצאת ברחוב בלה בלה 122, עיר אחרת.'),
                      ),
                      CallForHelpCard(
                        call: CallForHelpModel(
                            callerName: 'פלונית אלמונית',
                            time: '16:20',
                            message:
                                'פלוית אלמונית צריכה עזרה, היא נמצאת בכתובת רחוב 10, עיר, ישראל. לפי מיקום GPS נמצאת ברחוב בלה בלה 122, עיר אחרת.'),
                      ),
                    ],
                  ),
                ),
              ),
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        // If no data, show loading until new data will arrived
        if (snapshot.hasData == false) {
          return Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }

        // Build formatted list of all messages
        final messages = snapshot.data.documents.reversed;
        List<CallForHelpCard> messagesList = [];
        for (DocumentSnapshot msg in messages) {
          final callCard = CallForHelpCard(
            call: CallForHelpModel(
              callerName: msg.data['caller'],
              time: msg.data['time'],
              message: msg.data['message'],
            ),
          );
          messagesList.add(callCard);
        }

        // return widget to display
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messagesList,
          ),
        );
      },
    );
  }
}
