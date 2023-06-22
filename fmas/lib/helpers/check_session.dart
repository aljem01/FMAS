// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
// import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fma_project/screens/flood_notify_resident_high_alert.dart';
import 'package:fma_project/screens/flooding_danger.dart';
import 'package:fma_project/screens/flooding_safe.dart';
import 'package:fma_project/screens/flooding_warning.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
import '../helpers/routes.dart';
import 'package:http/http.dart' as http;

import '../screens/flood_notify_resident_low_alert.dart';

class CheckSession {
  void checkSessionInfo(context) async {
    try {
      AndroidOptions _getAndroidOptions() => const AndroidOptions(
            encryptedSharedPreferences: true,
          );
      final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
      // final storage = FlutterSecureStorage();
      final userData = (await storage.read(key: 'loggedInUser')) ?? '';
      final userDataFirstReading =
          (await storage.read(key: 'loggedInUserFirstReading')) ?? '';
      if (userData == '') {
        Navigator.pushNamed(context, AppRoute.loginScreenRoute);
      } else {
        final sessionJson = jsonDecode(userData);
        final account = sessionJson['account'];
        /*
        await Isolate.run(() async {
          final wsUrl = Uri.parse('ws://localhost:1234');
          var channel = WebSocketChannel.connect(wsUrl);
          while (true) {
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
            channel.stream.listen((message) {
              channel.sink.add(waterLevel);
            });
          }
        });
        */
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

        final userDataFirstReading =
            (await storage.read(key: 'loggedInUserFirstReading')) ?? '';
        if (userDataFirstReading == '') {
          await storage.write(
              key: 'loggedInUserFirstReading', value: "$waterLevel");
          await http
              .read(Uri.parse("https://agrox.farm/fmas/send/SMS/$waterLevel"));
        }

        if (waterLevel < 220) {
          if (account == "Authority") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const FloodNotifyResidentLowAlertScreen()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SafeFloodingScreen()));
          }
        } else {
          if (waterLevel < 260) {
            if (account == "Authority") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          const FloodNotifyResidentLowAlertScreen()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const WarningFloodingScreen()));
            }
          } else {
            if (account == "Authority") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          const FloodNotifyResidentHighAlertScreen()));
            } else {
              /*
              await http.read(
                  Uri.parse("https://agrox.farm/fmas/send/SMS/$waterLevel"));
                  */
              if (userDataFirstReading != "") {
                if (userDataFirstReading != waterLevel) {
                  await storage.write(
                      key: 'loggedInUserFirstReading', value: "$waterLevel");
                  await http.read(Uri.parse(
                      "https://agrox.farm/fmas/send/SMS/$waterLevel"));
                }
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const DangerFloodingScreen()));
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
/*
get_employees/{json}
get_user_details/{json}
check_user_session/{json}
*/
