// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';
import '../helpers/strings.dart';

import '../helpers/assets.dart';
import '../helpers/colors.dart';
import '../helpers/routes.dart';
import '../helpers/form_processing.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _currentResidencyValue = 'Resident';
  final _residencies = ["Resident", "Authority"];
  @override
  void initState() {
    super.initState();
    _currentResidencyValue = 'Resident';
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();

    passwordController.dispose();

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
                height: 320,
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
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoute.defaultRoute);
                            },
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            AppString.login,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    /*
                    DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownvalue = value!;
                        });
                      },
                    ),
                    */
                    Container(
                      width: 200,
                      height: 30,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        color: AppColor.primaryColor,
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      // padding: const EdgeInsets.all(1.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                fillColor: AppColor.primaryColor,
                                filled: true,
                                contentPadding: const EdgeInsets.all(5),
                                labelStyle: const TextStyle(
                                    color: AppColor.cardColor, fontSize: 10.0),
                                // errorStyle: const TextStyle(
                                //     color: Colors.redAccent, fontSize: 10.0),
                                //  hintText: 'Please select residency status',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            isEmpty: _currentResidencyValue == '',
                            child: DropdownButtonHideUnderline(
                              // ignore: duplicate_ignore
                              child: DropdownButton<String>(
                                isExpanded: true,
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.white,
                                isDense: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 30.0),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                //  iconSize: 40.0,
                                value: _currentResidencyValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _currentResidencyValue = newValue!;
                                    state.didChange(newValue);
                                    if (_currentResidencyValue == "Authority") {
                                      Navigator.pushNamed(context,
                                          AppRoute.loginCodeScreenRoute);
                                    }
                                  });
                                },
                                items: _residencies.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: AppColor.cardColor,
                                            fontSize: 12.0)),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    CoolTextField(
                        name: "Email", fullNameController: usernameController),
                    CoolTextField(
                        name: AppString.password,
                        fullNameController: passwordController),
                    Container(
                      width: double.infinity,
                      height: 40,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 10),
                      child: TextButton(
                          style: ButtonStyle(
                              //  foregroundColor: AppColor.customPrimaryColor,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            /*side: const BorderSide(
                                          color: AppColor.primaryColor)*/
                          ))),
                          onPressed: () {
                            final name = usernameController.text;
                            /*
                            usernameController.text =
                                "THIS IS IT USERNAME" + name;
                                */
                            final password = passwordController.text;
                            final user = ProcessForm();
                            /*
                            passwordController.text =
                                "THIS IS IT PASSWORD " + password;
                                */
                            // final json = {
                            //   'name': name,
                            //   'password': password,
                            //   'account': _currentResidencyValue,
                            // };

                            // Uri.parse('https://dart.dev/f/packages/http.json');
                            Fluttertoast.showToast(
                                msg:
                                    "Authentification in progress, please wait ...",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color.fromRGBO(0, 255, 0, 0.8),
                                textColor: Colors.white,
                                fontSize: 16.0);
                            String json = '{"account": "' +
                                _currentResidencyValue +
                                '", "name": "' +
                                name +
                                '", "password": "' +
                                password +
                                '", "action": "login"}';

                            user.getData(json, "Resident", context);
                            // Response response = awaits get("http://localhost/agrox/fmas/get_employees");
                            /*
                            Fluttertoast.showToast(
                                msg: "This is a toast message",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color.fromRGBO(255, 0, 0, 1),
                                textColor: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 12);
                                */
                            // CreateUser(name: name, password: password);
                            // Navigator.pushNamed(context, AppRoute.defaultRoute);
                            // Navigator.pushNamed(context, AppRoute.defaultRoute);
                          },
                          child: const Text(AppString.login,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w800))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppString.forgotPassword,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                            onTap: () {},
                            child: const Text(
                              AppString.clickHere,
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

// ignore: non_constant_identifier_names
/*
Future CreateUser({required String name, required String password}) async {
  // ignore: unused_local_variable
  var FirebaseFirestore;
  final user = FirebaseFirestore.instance.collection('users').doc();
  final json = {
    'name': name,
    'password': password,
  };
  await user.set(json);
}
*/
void getData(json, context) async {
  // final httpPackageUrl = Uri.parse(
  //     'https://api.thingspeak.com/channels.json?api_key=MUEYIB55LV3BCSMW');
  final httpPackageUrl =
      Uri.parse("https://agrox.farm/fmas/get_employees/" + json);
  final httpPackageInfo = await http.read(httpPackageUrl);
  // print(httpPackageInfo);
  if (httpPackageInfo == "success") {
    Navigator.pushNamed(context, AppRoute.safeFloodScreenRoute);
  } else {
    if (httpPackageInfo == "proceed to login") {
      Navigator.pushNamed(context, AppRoute.loginCodeScreenRoute);
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: httpPackageInfo,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(255, 0, 0, 0.8),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
