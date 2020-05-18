import 'package:cloud_firestore/cloud_firestore.dart';

class CallForHelpModel {
  CallForHelpModel({this.callerName, this.time, this.message});

  final String callerName;
  final Timestamp time;
  final String message;
}