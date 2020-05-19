import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifecompassapp/components/call_for_help_card.dart';
import 'package:lifecompassapp/constants.dart';
import 'package:lifecompassapp/models/call_for_help_model.dart';
import 'package:lifecompassapp/screens/help_details_screen.dart';
import 'package:lifecompassapp/services/push_nofitications.dart';

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
    PushNotificationsManager().init();
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
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 0.5,
                    spreadRadius: 0.0,
                    offset: Offset(0.5, 0.5),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 7,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            Expanded(
              child: CallsStream(),
            ),
          ],
        ),
      );

  get header => ListTile(
        contentPadding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        title: Text(
          currentUser != null && currentUser.displayName != null
              ? currentUser.displayName
              : '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        leading: CircleAvatar(
          foregroundColor: kPrimaryColor,
          backgroundColor: Colors.white,
          radius: 20.0,
          child: Icon(
            FlutterIcons.user_faw,
            size: 30.0,
          ),
        ),
      );
}

class CallsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection(kMainCollectionName)
          .orderBy(kTimeStampKey, descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        // If no data, show loading until new data will arrived
        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
            ),
          );
        }

        // Build formatted list of all messages
        final messages = snapshot.data.documents.reversed;
        List<CallForHelpCard> messagesList = [];
        for (DocumentSnapshot msg in messages) {
          final callModel = CallForHelpModel(
            callerName: msg.data[kCallerNameKey],
            time: msg.data[kTimeStampKey],
            message: msg.data[kMessageKey],
          );
          final callCard = CallForHelpCard(
            call: callModel,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: HelpDetailsScreen(
                      call: callModel,
                      callDatabaseUid: msg.documentID,
                    ),
                  ),
                ),
              );
            },
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
