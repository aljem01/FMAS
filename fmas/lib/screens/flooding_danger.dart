// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fma_project/helpers/assets.dart';
import 'package:fma_project/helpers/colors.dart';
import 'package:fma_project/helpers/routes.dart';
import 'package:fma_project/helpers/strings.dart';
import 'package:fma_project/screens/flooding_safe.dart';
import 'package:fma_project/screens/flooding_warning.dart';
import 'package:fma_project/screens/resident_notifications_screen.dart';
import 'package:http/http.dart' as http;
import "package:url_launcher/url_launcher.dart" as UrlLauncher;

class DangerFloodingScreen extends StatefulWidget {
  const DangerFloodingScreen({super.key});
  @override
  State<DangerFloodingScreen> createState() => _DangerFloodingScreenState();
}

class _DangerFloodingScreenState extends State<DangerFloodingScreen> {
  _DangerFloodingScreenState();
  int _waterLevel = 0;
  int _chanceOfFlooding = 0;
  int _precipitation = 0;
  Timer? timer;
  int rank = 0;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      getData();
      setState(() => {});
    });
  }

  void getData() async {
    try {
      final fromSensor = await http.read(
          Uri.parse("https://api.thingspeak.com/channels/2186309/feeds.json"));
      final parsedJson = jsonDecode(fromSensor);
      final lastEnteredID = parsedJson['channel']['last_entry_id'];
      final feeds = parsedJson['feeds'];
      for (var eachFeed in feeds) {
        if (eachFeed['entry_id'] == lastEnteredID) {
          _waterLevel = int.parse(eachFeed["field1"]);
          if (_waterLevel > 100) {
            _chanceOfFlooding = 100;
          } else {
            _chanceOfFlooding = _waterLevel;
          }
        }
      }
      if (_waterLevel < 220) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SafeFloodingScreen()));
      } else {
        if (_waterLevel < 260) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const WarningFloodingScreen()));
        } else {}
      }
    } catch (e) {}
    try {
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
      if (response.statusCode == 200) {
        final parsedJson = jsonDecode(await response.stream.bytesToString());
        _precipitation = parsedJson["data"]["precipIntensity"];
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    startTimer();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: height,
            width: width,
            color: AppColor.dangerFloodColor,
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height,
                width: width,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    SvgPicture.asset(AppAsset.countryUgandaSvg,
                        //  color: Colors.transparent.withOpacity(0.2),
                        semanticsLabel: 'Asset'),
                    Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 80.0,
                          width: 100.0,
                          child: SvgPicture.asset(AppAsset.houseSvg,
                              semanticsLabel: 'Asset'),
                        ))
                  ],
                ),
              )),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: height * .45,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColor.cardColor,
                              child: Icon(
                                Icons.location_pin,
                                size: 35,
                              ),
                            ),
                            const Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  AppString.riverName,
                                  style: TextStyle(
                                      color: AppColor.cardColor,
                                      fontSize: 33,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  AppString.likelyToFlood + AppString.threeDays,
                                  style: TextStyle(
                                      color: AppColor.cardColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            CircleAvatar(
                                backgroundColor: AppColor.cardColor,
                                child: IconButton(
                                  icon: const Icon(Icons.account_circle),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.profileScreenRoute);
                                  },
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 65),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 0, top: 0),
                        child: Column(
                          children: [
                            Text(
                              "$_chanceOfFlooding%",
                              style: const TextStyle(
                                  color: AppColor.cardColor,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Text(
                              AppString.chanceOfFlooding,
                              style: TextStyle(
                                  color: AppColor.cardColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ]),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height * .50,
              width: width * .9,
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor,
                      offset: Offset(0.4, 1.0), //(x,y)
                      blurRadius: 60.0,
                    ),
                  ],
                  color: AppColor.cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.defaultRoute);
                          },
                        ),
                        const Text(
                          AppString.details,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () async {
                            final fromSensor = await http.read(Uri.parse(
                                "https://api.thingspeak.com/channels/2186309/feeds.json"));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ResidentNotificationScreen(
                                        jsonData: fromSensor)));
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 140,
                          width: 140,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.0, 1.0),
                              stops: [0.0, 1.0],
                              colors: <Color>[
                                AppColor.dangerFloodColor,
                                AppColor.primaryColor
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.cloud_rain,
                                size: 34,
                                color: AppColor.cardColor,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                AppString.rainfallIntensity,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.cardColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "$_precipitation",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.cardColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 140,
                          width: 140,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                AppColor.dangerFloodColor,
                                AppColor.primaryColor
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.water,
                                size: 34,
                                color: AppColor.cardColor,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                AppString.waterLevel,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.cardColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "$_waterLevel",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.cardColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (state) => AppColor.emergencyColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color: AppColor.primaryColor)))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.call),
                              onPressed: () async {
                                UrlLauncher.launchUrl(
                                    "tel://0772620836" as Uri);
                              },
                            ),
                            const SizedBox(width: 20),
                            const Text(AppString.callEmergency,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w800)),
                          ],
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppString.registerFamilyMember,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                          onTap: () {},
                          child: const Text(
                            AppString.register,
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
