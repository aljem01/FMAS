import 'package:flutter/material.dart';
import '../helpers/strings.dart';
import '../screens/all_screens.dart';
import '../screens/welcome_screen.dart';

import 'helpers/colors.dart';
import 'helpers/routes.dart';
import 'home_page/home_page.dart';
import 'screens/authority_notifications_screen.dart';
import 'screens/flood_notify_resident_high_alert.dart';
import 'screens/flood_notify_resident_low_alert.dart';
import 'screens/flooding_danger.dart';
import 'screens/flooding_safe.dart';
import 'screens/flooding_screen.dart';
import 'screens/flooding_warning.dart';
import 'screens/login_code_screen.dart';
import 'screens/login_screen.dart';
import 'screens/resident_notifications_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/signup_code_screen.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
        AppRoute.residentNotificationScreenRoute: (context) =>
            const ResidentNotificationScreen(),
        AppRoute.authorityNotificationScreenRoute: (context) =>
            const AuthorityNotificationScreen(),
        // flood screens
        AppRoute.dangerFloodScreenRoute: (context) =>
            const DangerFloodingScreen(),
        AppRoute.warningFloodScreenRoute: (context) =>
            const WarningFloodingScreen(),
        AppRoute.safeFloodScreenRoute: (context) => const SafeFloodingScreen(),
        AppRoute.notifyResidentHighAlertScreenRoute: (context) =>
            const FloodNotifyResidentHighAlertScreen(),
        AppRoute.notifyResidentLowAlertScreenRoute: (context) =>
            const FloodNotifyResidentLowAlertScreen(),
      },
    );
  }
}
