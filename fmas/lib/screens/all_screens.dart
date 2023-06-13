import 'package:flutter/material.dart';
import '../helpers/routes.dart';

class SampleScreens extends StatefulWidget {
  const SampleScreens({super.key});

  @override
  State<SampleScreens> createState() => _SampleScreensState();
}

class _SampleScreensState extends State<SampleScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FMAS SCREENS ( 95% finished)'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CoolRouteButton(
              name: 'Welcome',
              route: AppRoute.welcomeScreenRoute,
            ),
            CoolRouteButton(
              name: 'Login',
              route: AppRoute.loginScreenRoute,
            ),
            CoolRouteButton(
              name: 'Login Code',
              route: AppRoute.loginCodeScreenRoute,
            ),
            CoolRouteButton(
              name: 'Sign Up',
              route: AppRoute.signupScreenRoute,
            ),
            CoolRouteButton(
              name: 'Sign Up Code',
              route: AppRoute.signupCodeRoute,
            ),
            CoolRouteButton(
              name: 'Danger',
              route: AppRoute.dangerFloodScreenRoute,
            ),
            CoolRouteButton(
              name: 'Warning',
              route: AppRoute.warningFloodScreenRoute,
            ),
            CoolRouteButton(
              name: 'Safe',
              route: AppRoute.safeFloodScreenRoute,
            ),
            CoolRouteButton(
              name: 'Resident Notification',
              route: AppRoute.residentNotificationScreenRoute,
            ),
            CoolRouteButton(
              name: 'Authority Notification',
              route: AppRoute.authorityNotificationScreenRoute,
            ),
            CoolRouteButton(
              name: 'Flood Notify Resident High Alert',
              route: AppRoute.notifyResidentHighAlertScreenRoute,
            ),
            CoolRouteButton(
              name: 'Flood Notify Resident Low Alert',
              route: AppRoute.notifyResidentLowAlertScreenRoute,
            ),
            CoolRouteButton(
              name: 'Profile',
              route: AppRoute.profileScreenRoute,
            ),
          ],
        ),
      ),
    );
  }
}

class CoolRouteButton extends StatelessWidget {
  const CoolRouteButton({super.key, required this.name, required this.route});
  final String name;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(
            name,
            textAlign: TextAlign.center,
          )),
    );
  }
}
