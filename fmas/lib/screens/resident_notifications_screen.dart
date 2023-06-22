// ignore_for_file: avoid_print, prefer_final_fields

// import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fma_project/helpers/assets.dart';
import 'package:fma_project/helpers/check_session.dart';
import 'package:fma_project/helpers/colors.dart';
import 'package:fma_project/helpers/strings.dart';
// import 'package:http/http.dart' as http;

class ResidentNotificationScreen extends StatefulWidget {
  final String jsonData;
  const ResidentNotificationScreen({
    super.key,
    required this.jsonData,
  });
  @override
  State<ResidentNotificationScreen> createState() =>
      _ResidentNotificationScreenState();
}

class _ResidentNotificationScreenState
    extends State<ResidentNotificationScreen> {
  var _commentWidgets = <Widget>[];

  void loadWidgets(json) {
    // _commentWidgets.clear();
    int waterLevel = 0;
    final parsedJson = jsonDecode(json);
    final feeds = parsedJson['feeds'];
    int index = 0;
    for (var eachFeed in feeds) {
      index++;
      if (index > 1) {
        if (int.parse(feeds[index - 1]["field1"]) ==
            int.parse(feeds[index - 2]["field1"])) {
          continue;
        }
      }
      waterLevel = int.parse(eachFeed["field1"]);
      var waterLevelFinal = waterLevel.toString();
      if (waterLevel < 50) {
        _commentWidgets.add(
          Container(
            width: 200.0,
            height: 70.0,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                  color: Colors.green,
                  width: 1,
                )),
            child: Row(children: [
              const SizedBox(width: 20),
              const Icon(
                Icons.check_circle_outline,
                size: 30,
                color: AppColor.greenFloodColor,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 240,
                child: Text(
                    "There is a $waterLevelFinal% chance of floods in R. Mobuku Area with water level at $waterLevelFinal ml",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w400)),
              ),
            ]),
          ),
        );
      } else {
        if (waterLevel < 100) {
          _commentWidgets.add(
            Container(
              width: 200.0,
              height: 70.0,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: Colors.orange,
                    width: 1,
                  )),
              child: Row(children: [
                const SizedBox(width: 20),
                const Icon(Icons.warning_amber_outlined,
                    size: 30, color: AppColor.warningFloodColor),
                const SizedBox(width: 10),
                SizedBox(
                  width: 240,
                  child: Text(
                      "There is a $waterLevelFinal% chance of floods in R. Mobuku Area with water level at $waterLevelFinal ml",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w400)),
                ),
              ]),
            ),
          );
        } else {
          _commentWidgets.add(
            Container(
              width: 200.0,
              height: 70.0,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  )),
              child: Row(children: [
                const SizedBox(width: 20),
                const Icon(
                  Icons.warning_sharp,
                  size: 30,
                  color: AppColor.dangerFloodColor,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 240,
                  child: Text(
                      "There is a 100% chance of floods in R. Mobuku Area with water level at $waterLevelFinal ml",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w400)),
                ),
              ]),
            ),
          );
        }
      }
    }
/*
    for (var i = 0; i < 10; i++) {
      _commentWidgets.add(
        Container(
          width: 200.0,
          height: 70.0,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: Colors.green,
                width: 1,
              )),
          child: const Row(children: [
            SizedBox(width: 20),
            Icon(
              Icons.check_circle_outline,
              size: 30,
              color: AppColor.greenFloodColor,
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 240,
              child: Text(AppString.notificationText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
            ),
          ]),
        ),
      ); // TODO: Whatever layout you need for each widget.
    }
      */
  }

  @override
  Widget build(BuildContext context) {
    String json = widget.jsonData;
    // print(json);
    // startTimer();
    loadWidgets(json);
    // final fromSensor = await http.read(Uri.parse(
    //         "https://api.thingspeak.com/channels/2186309/feeds.json"));
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
                        //     color: Colors.transparent.withOpacity(0.2),
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.cardColor,
                              child: Icon(
                                Icons.location_pin,
                                size: 35,
                              ),
                            ),
                            Column(
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
                              child: Icon(
                                Icons.account_circle,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 65),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 0, top: 0),
                        child: const Column(
                          children: [
                            Text(
                              AppString.percentageChance90,
                              style: TextStyle(
                                  color: AppColor.cardColor,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
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
              height: height * .85,
              width: width * .9,
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
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
                          onPressed: () async {
                            CheckSession().checkSessionInfo(context);
                          },
                        ),
                        const Text(
                          AppString.notifications,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .6,
                    width: double.infinity,
                    child: ListView(
                      shrinkWrap: true,
                      children: _commentWidgets,
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              size: 25,
                            ),
                            SizedBox(width: 20),
                            Text(AppString.callEmergency,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800)),
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
