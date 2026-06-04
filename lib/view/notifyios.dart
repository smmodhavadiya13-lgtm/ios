import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//auth commit 1
class _HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    requestPermission();
    getToken();
    setupFirebase();
  }

  //auth commit 2
  void requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    //main latest

    print("Permission: ${settings.authorizationStatus}");
  }

  void getToken() async {
    String? token = await _messaging.getToken();
    print("FCM Token: $token");
  }

  void setupFirebase() {
    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground: ${message.notification?.title}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Clicked notification");
    });
  }

  //main commit
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Push Notification")),
      body: const Center(child: Text("Waiting for notification...")),
    );
  }
}
