// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../helpers/routes.dart';
import 'package:http/http.dart' as http;

import '../screens/flooding_danger.dart';
import '../screens/flooding_safe.dart';
import '../screens/flooding_warning.dart';

class ProcessForm {
  void getData(json, account, context) async {
    try {
      // final httpPackageUrl = Uri.parse(
      //     'https://api.thingspeak.com/channels.json?api_key=MUEYIB55LV3BCSMW');
      final httpPackageInfo = await http
          .read(Uri.parse("https://agrox.farm/fmas/get_employees/" + json));
      // print(httpPackageInfo);
      if (httpPackageInfo == "success") {
        final fromSensor = await http.read(Uri.parse(
            "https://api.thingspeak.com/channels.json?api_key=MUEYIB55LV3BCSMW"));
        // print(fromSensor);
        // print(getSensorReadings(fromSensor));
        int ranking = getSensorReadings(fromSensor);

        var headers = {
          'x-api-key':
              'b81175a8e04ba17d946c19e283919b72b479d8835be39363b93682aadebe9592',
          'Content-type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                'https://api.ambeedata.com/weather/latest/by-lat-lng?lat=0.347596&lng=32.582520'));
        request.body = '''''';
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        int precipitation = 0;

        if (response.statusCode == 200) {
          final parsedJson = jsonDecode(await response.stream.bytesToString());
          precipitation = parsedJson["data"]["precipIntensity"];
        }
        if (ranking < 50) {
          // Navigator.pushNamed(context, AppRoute.safeFloodScreenRoute);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SafeFloodingScreen(
                      ranking: ranking, precipitation: precipitation)));
        } else {
          if (ranking < 69) {
            /*
            Navigator.pushNamed(
                context, AppRoute.warningFloodScreenRoute(ranking: ranking));
                */
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => WarningFloodingScreen(
                        ranking: ranking, precipitation: precipitation)));
          } else {
            // Navigator.pushNamed(context, AppRoute.dangerFloodScreenRoute);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DangerFloodingScreen(
                        ranking: ranking, precipitation: precipitation)));
          }
        }
      } else {
        if (httpPackageInfo == "proceed to login") {
          if (account == "Authority") {
            Navigator.pushNamed(context, AppRoute.loginCodeScreenRoute);
          } else {
            Navigator.pushNamed(context, AppRoute.loginScreenRoute);
          }
        } else {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
              msg: httpPackageInfo,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              // ignore: prefer_const_constructors
              backgroundColor: Color.fromRGBO(255, 0, 0, 0.8),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } catch (e) {
      // TODO: handle exception, for example by showing an alert to the user
      print(e);
    }
  }

  int getSensorReadings(fromSensor) {
    final jsonData = fromSensor;
    // 2. decode the json
    final parsedJson = jsonDecode(jsonData);
    // 3. print the type and value
    // return '${parsedJson.runtimeType} : $parsedJson';
    return parsedJson[0]['ranking'];
  }
}
