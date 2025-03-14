import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../helpers/strings.dart';

import '../helpers/assets.dart';
import '../helpers/colors.dart';
import '../helpers/routes.dart';

// import 'package:geolocator/geolocator.dart';
//
class SafeFloodingScreen extends StatefulWidget {
  final int ranking;
  final int precipitation;
  const SafeFloodingScreen(
      {super.key, required this.ranking, required this.precipitation});
  @override
  State<SafeFloodingScreen> createState() =>
      _SafeFloodingScreenState(ranking: ranking, precipitation: precipitation);
}

void getLocation() async {
  // Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high);
}

class _SafeFloodingScreenState extends State<SafeFloodingScreen> {
  bool buttonDisabled = true;
  int ranking;
  int precipitation;
  _SafeFloodingScreenState(
      {required this.ranking, required this.precipitation});
  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        () {
          print("This is a timing event");
        };
      });
    });
    String rankingFinal = "$ranking %";
    String precipitationFinal = "$precipitation mm/h";
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: height,
            width: width,
            color: AppColor.greenFloodColor,
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
                        //    color: Colors.transparent.withOpacity(0.2),
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
                                  AppString.areaTwo,
                                  style: TextStyle(
                                      color: AppColor.cardColor,
                                      fontSize: 33,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  AppString.notLikelyToFlood,
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
                        child: Column(
                          children: [
                            Text(
                              rankingFinal,
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
                        const Icon(
                          Icons.notifications,
                          size: 25,
                          color: AppColor.primaryColor,
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
                                AppColor.greenFloodColor,
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
                                precipitationFinal,
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
                                AppColor.greenFloodColor,
                                AppColor.primaryColor
                              ],
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.water,
                                size: 34,
                                color: AppColor.cardColor,
                              ),
                              SizedBox(height: 5),
                              Text(
                                AppString.waterLevel,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.cardColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 5),
                              Text(
                                AppString.unitSix,
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                                (state) => buttonDisabled
                                    ? AppColor.disbledButtonColor
                                    : AppColor.emergencyColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: buttonDisabled
                                            ? AppColor.disbledButtonColor
                                            : AppColor.primaryColor)))),
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
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoute.signupScreenRoute);
                          },
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
