import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lifecompassapp/constants.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (map) async {
          print('onMessage');
        },
        onLaunch: (map) async {
          print('onLaunch');
        },
        onResume: (map) async {
          print('onResume');
        },
      );

      // Subscribe to location topic
      await _firebaseMessaging.subscribeToTopic(kTopicName);

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}
