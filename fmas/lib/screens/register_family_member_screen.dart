import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../helpers/strings.dart';

import '../helpers/assets.dart';
import '../helpers/colors.dart';
import '../helpers/routes.dart';
import '../helpers/form_processing.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterFamilyMember extends StatefulWidget {
  const RegisterFamilyMember({super.key});
  @override
  State<RegisterFamilyMember> createState() => _RegisterFamilyMemberState();
}

class _RegisterFamilyMemberState extends State<RegisterFamilyMember> {
  // String _currentResidencyValue = 'Resident';
  // final _residencies = ["Resident", "Authority"];
  bool _agree = false;
  @override
  void initState() {
    super.initState();
    // _currentResidencyValue = 'Resident';
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    contactController.dispose();
    placeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(children: [
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
                height: 600,
                width: width * .9,
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                padding: const EdgeInsets.only(
                    left: 5, right: 5, bottom: 5, top: 10),
                decoration: const BoxDecoration(
                    color: AppColor.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            // ignore: prefer_const_constructors
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoute.defaultRoute);
                            },
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          const Text(
                            AppString.signup,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    CoolTextField(
                        name: AppString.fullName,
                        fullNameController: fullNameController),
                    CoolTextField(
                        name: AppString.phoneContact,
                        fullNameController: contactController),
                    CoolTextField(
                        name: AppString.placeOfResidence,
                        fullNameController: placeController),
                    CoolTextField(
                        name: AppString.emailAddress,
                        fullNameController: emailController),
                    CoolTextField(
                        name: AppString.password,
                        fullNameController: passwordController),
                    CoolTextField(
                        name: AppString.confirmPassword,
                        fullNameController: confirmPasswordController),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _agree,
                            onChanged: (bool? value) {
                              setState(() {
                                _agree = value!;
                              });
                            },
                          ),
                          const Text(AppString.agreeToTerms,
                              style: TextStyle(
                                  color: AppColor.textColor, fontSize: 12.0)),
                        ],
                      ),
                    ),
                    Expanded(
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
                            final name = fullNameController.text;
                            final contact = contactController.text;
                            final residence = placeController.text;
                            final username = emailController.text;
                            final password = passwordController.text;

                            if (password == confirmPasswordController.text) {
                              final user = ProcessForm();

                              Fluttertoast.showToast(
                                  msg:
                                      "Authentification in progress, please wait ...",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      const Color.fromRGBO(0, 255, 0, 0.8),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              String json =
                                  '{"account": "Resident", "name": "$name", "contact": "$contact", "residence": "$residence", "username": "$username", "password": "$password", "action": "register"}';
                              user.getDataRegisterFamily(
                                  json, "Resident", context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Passwords do not match",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      const Color.fromRGBO(255, 0, 0, 0.8),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: const Text(AppString.createAccount,
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
                            onTap: () {},
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
      ),
    );
  }
}

class CoolTextField extends StatelessWidget {
  const CoolTextField({
    super.key,
    required this.name,
    required this.fullNameController,
  });
  final String name;
  final TextEditingController fullNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(name,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.only(left: 10),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  //  hintText: AppString.fullName,
                  fillColor: AppColor.textFieldColor),
            ),
          )
        ],
      ),
    );
  }
}
