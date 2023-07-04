import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flood_monitoring_app/homePage/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/uganda',
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification for the basic channel',
          playSound: true,
          onlyAlertOnce: false,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.deepPurple,
          ledColor: Colors.deepPurple),
    ],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flood Monitoring & Alert App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 255, 145)),
        useMaterial3: true,
      ),
      // home: const HomePage(title: 'Flood Monitoring and Alert App'),
      home: const HomePage(),
    );
  }
}
