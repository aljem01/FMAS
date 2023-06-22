// ignore_for_file: prefer_const_constructors

// import 'dart:isolate';

import 'dart:async';
import 'dart:convert';
// import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:workmanager/workmanager.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:firebase_core/firebase_core.dart';
import '../helpers/strings.dart';
import '../screens/all_screens.dart';
import '../screens/welcome_screen.dart';

import 'helpers/colors.dart';
import 'helpers/routes.dart';
import 'home_page/home_page.dart';
import 'screens/authority_notifications_screen.dart';
import 'screens/flood_notify_resident_high_alert.dart';
import 'screens/flood_notify_resident_low_alert.dart';
import 'screens/flooding_screen.dart';
import 'screens/login_code_screen.dart';
import 'screens/login_screen.dart';
// import 'screens/resident_notifications_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/signup_code_screen.dart';
import 'screens/signup_screen.dart';
import 'package:http/http.dart' as http;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerOneOffTask("uniqueName", "taskName");
  // await Firebase.initializeApp;
  /*
  await Isolate.run(() async {
    startTimer();
    Timer? timer;
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      print("try");
    });
    print("Now this");
  });
  */
  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      AndroidOptions _getAndroidOptions() => const AndroidOptions(
            encryptedSharedPreferences: true,
          );
      final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
      // final storage = FlutterSecureStorage();
      final userData = (await storage.read(key: 'loggedInUser')) ?? '';
      final userDataFirstReading =
          (await storage.read(key: 'loggedInUserFirstReading')) ?? '';
      final userDetailsData =
          (await storage.read(key: 'loggedInUserDetails')) ?? '';
      if ((userData == '') ||
          (userDataFirstReading == '') ||
          (userDetailsData == '')) {
        await storage.deleteAll();
      } else {
        final fromSensor = await http.read(Uri.parse(
            "https://api.thingspeak.com/channels/2186309/feeds.json"));
        final parsedJson = jsonDecode(fromSensor);
        final lastEnteredID = parsedJson['channel']['last_entry_id'];
        var waterLevel = 0;
        final feeds = parsedJson['feeds'];
        feeds.forEach((eachFeed) => {
              if (eachFeed['entry_id'] == lastEnteredID)
                {waterLevel = int.parse(eachFeed["field1"])}
            });
        await storage.write(
            key: 'loggedInUserFirstReading', value: "$waterLevel");
        await http
            .read(Uri.parse("https://agrox.farm/fmas/send/SMS/$waterLevel"));
        final userDetails = await http.read(
            Uri.parse("https://agrox.farm/fmas/get_user_details/$userData"));
        await storage.write(key: 'loggedInUserDetails', value: userDetails);
      }
    } catch (e) {
      print(e);
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appNameAbbreviation,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColor.customPrimaryColor,
          canvasColor: AppColor.customPrimaryColor,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: AppColor.customPrimaryColor,
          ).copyWith(),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (state) => AppColor.customPrimaryColor),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (state) => AppColor.cardColor)))),
      initialRoute: AppRoute.defaultRoute,
      routes: {
        AppRoute.defaultRoute: (context) => const HomePage(),
        AppRoute.allScreensRoute: (context) => const SampleScreens(),
        AppRoute.welcomeScreenRoute: (context) => const WelcomeScreen(),
        AppRoute.floodingScreenRoute: (context) => const FloodingScreen(),
        AppRoute.loginScreenRoute: (context) => const LoginScreen(),
        AppRoute.loginCodeScreenRoute: (context) => const LoginCodeScreen(),
        AppRoute.signupScreenRoute: (context) => const SignupScreen(),
        AppRoute.signupCodeRoute: (context) => const SignupCodeScreen(),
        AppRoute.profileScreenRoute: (context) => const ProfileScreen(),
        // AppRoute.residentNotificationScreenRoute: (context) =>
        //     const ResidentNotificationScreen(),
        AppRoute.authorityNotificationScreenRoute: (context) =>
            const AuthorityNotificationScreen(),
        // flood screens
        /*
        AppRoute.dangerFloodScreenRoute: (context) =>
            const DangerFloodingScreen(),
        AppRoute.warningFloodScreenRoute: (context) =>
            WarningFloodingScreen(ranking: 50),
        AppRoute.safeFloodScreenRoute: (context) => const SafeFloodingScreen(),
        */
        AppRoute.notifyResidentHighAlertScreenRoute: (context) =>
            const FloodNotifyResidentHighAlertScreen(),
        AppRoute.notifyResidentLowAlertScreenRoute: (context) =>
            const FloodNotifyResidentLowAlertScreen(),
      },
    );
  }
}
