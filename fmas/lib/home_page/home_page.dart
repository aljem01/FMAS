import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../helpers/assets.dart';
import '../helpers/colors.dart';
import '../helpers/routes.dart';
import '../helpers/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: height,
            width: width,
            color: AppColor.customPrimaryColor,
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(AppAsset.countryUgandaSvg,
                  semanticsLabel: 'Asset')),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              width: width * .9,
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      child: const CircleAvatar(
                        backgroundColor: AppColor.primaryColor,
                        radius: 5,
                      ),
                    ),
                  ),
                  const Text(
                    AppString.appName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    AppString.welcomeNote,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: TextButton(
                        style: ButtonStyle(
                            //  foregroundColor: AppColor.customPrimaryColor,
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color: AppColor.primaryColor)))),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoute.safeFloodScreenRoute);
                        },
                        child: const Text(AppString.getStarted,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w800))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppString.haveAccount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoute.loginScreenRoute);
                          },
                          child: const Text(
                            AppString.login,
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
