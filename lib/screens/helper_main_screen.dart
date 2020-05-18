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
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              dashBg,
              content,
            ],
          ),
        ),
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Theme.of(context).primaryColor),
            flex: 1,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 6,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            Expanded(child: MessagesStream()),
          ],
        ),
      );

  get header => ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 30),
        title: Text(
          currentUser != null && currentUser.displayName != null
              ? currentUser.displayName
              : '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
        ),
        leading: CircleAvatar(
          foregroundColor: Colors.teal,
          backgroundColor: Colors.white,
          radius: 22,
          child: Icon(
            FlutterIcons.user_faw,
            size: 32.0,
          ),
        ),
      );
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('helps_calls')
//          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        // If no data, show loading until new data will arrived
        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ),
          );
        }

        // Build formatted list of all messages
        final messages = snapshot.data.documents.reversed;
        List<CallForHelpCard> messagesList = [];
        for (DocumentSnapshot msg in messages) {
          print(msg);
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
        return Container(
          alignment: Alignment.topCenter,
          child: ListView(
            //reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messagesList,
          ),
        );
      },
    );
  }
}
