// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fma_project/helpers/assets.dart';
import 'package:fma_project/helpers/check_session.dart';
import 'package:fma_project/helpers/colors.dart';
import 'package:fma_project/helpers/strings.dart';
// import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool buttonDisabled = true;
  String _name = "";
  String _email = "";
  String _contact = "";
  Timer? timer;
  void startTimer() {
    checkSession();
    /*
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      checkSession();
      setState(() => {});
    });
    */
    // checkSession();
    // setState(() => {});
  }

  void checkSession() async {
    try {
      AndroidOptions _getAndroidOptions() => const AndroidOptions(
            encryptedSharedPreferences: true,
          );
      final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
      final userDetailsData =
          (await storage.read(key: 'loggedInUserDetails')) ?? '';
      if (userDetailsData == '') {
      } else {
        final parsedJson = jsonDecode(userDetailsData);
        _name = parsedJson['name'];
        _email = parsedJson['email'];
        _contact = parsedJson['phoneNumber'];
        setState(() => {});
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
                        child: const Column(
                          children: [
                            Text(
                              AppString.percentageChance30,
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
                          onPressed: () async {
                            CheckSession().checkSessionInfo(context);
                          },
                        ),
                        const Text(
                          AppString.profile,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 140,
                          width: 140,
                          child: Center(
                            child: DottedBorder(
                              dashPattern: const [6, 6, 6, 6],
                              borderType: BorderType.Circle,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.all(6),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  // color: Colors.amber,
                                  decoration: const BoxDecoration(
                                    color: AppColor.complimentColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: SvgPicture.asset(AppAsset.accountSvg,
                                      semanticsLabel: 'Asset'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(_name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800)),
                        Text(_email,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        Text(_contact,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        const CoolMenuItem(
                          name: AppString.contactUs,
                        ),
                        const CoolMenuItem(
                          name: AppString.privacyPolicy,
                        ),
                        const CoolMenuItem(
                          name: AppString.termsAndConditions,
                        ),
                        const CoolMenuItem(
                          name: AppString.settings,
                        ),
                        Container(
                          // margin: const EdgeInsets.all(15.0),
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          /*
                          child: const Text(
                            AppString.logout,
                            style: TextStyle(
                                color: AppColor.emergencyColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                                
                          ),
                          */
                          child: InkWell(
                            onTap: () async {
                              AndroidOptions _getAndroidOptions() =>
                                  const AndroidOptions(
                                    encryptedSharedPreferences: true,
                                  );
                              final storage = FlutterSecureStorage(
                                  aOptions: _getAndroidOptions());
                              // await storage.deleteAll();
                              await storage.delete(key: 'loggedInUser');
                              CheckSession().checkSessionInfo(context);
                            },
                            child: const Text(AppString.logout,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((state) =>
                                      buttonDisabled
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
                              Text(AppString.notifyResidentsNow,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800)),
                            ],
                          ))),
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

class CoolMenuItem extends StatelessWidget {
  const CoolMenuItem({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(15.0),
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                   <--- left side
            color: AppColor.textColor,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        name,
        style: const TextStyle(
            color: AppColor.textColor,
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
