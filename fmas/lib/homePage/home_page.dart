import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WebViewPlus(
        initialUrl: 'assets/index.html',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
              name: "FMAS",
              onMessageReceived: (JavascriptMessage result) async {
                result.message;
                if (result.message == "Make a phone call") {
                  /*
                  final Uri url = Uri(
                    scheme: 'tel',
                    path: '+256755313545',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    print("Failed to Launch the Calling App");
                  }
                  */
                  const number = '0800144444'; //set the number here
                  makeACall(number);
                }
                if (result.message.contains('notification')) {
                  var messageArr = result.message.split('::');
                  AwesomeNotifications()
                      .isNotificationAllowed()
                      .then((isAllowed) {
                    if (!isAllowed) {
                      AwesomeNotifications()
                          .requestPermissionToSendNotifications();
                    } else {
                      AwesomeNotifications().createNotification(
                          content: NotificationContent(
                              id: 1,
                              channelKey: 'basic_channel',
                              title: 'Flood Monitoring',
                              body: messageArr[1],
                              notificationLayout: NotificationLayout.BigText));
                    }
                  });
                }
              })
        },
      ),
    ));
  }
}

makeACall(phoneNumber) async {
  await FlutterPhoneDirectCaller.callNumber(phoneNumber);
}
