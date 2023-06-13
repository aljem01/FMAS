import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../helpers/strings.dart';

import '../helpers/assets.dart';
import '../helpers/colors.dart';

class LoginCodeScreen extends StatefulWidget {
  const LoginCodeScreen({super.key});
  @override
  State<LoginCodeScreen> createState() => _LoginCodeScreenState();
}

class _LoginCodeScreenState extends State<LoginCodeScreen> {
  String _currentResidencyValue = 'Resident';
  final _residencies = ["Resident", "Authority"];
  @override
  void initState() {
    super.initState();
    _currentResidencyValue = 'Resident';
  }

  TextEditingController loginCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    loginCodeController.dispose();
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
                height: 350,
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
                        children: const [
                          Icon(Icons.arrow_back,
                              size: 30, color: AppColor.primaryColor),
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
                              child: DropdownButton<String>(
                                isExpanded: true,
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.white,
                                isDense: true,
                                icon: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0, top: 0, right: 20),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                //  iconSize: 40.0,
                                value: _currentResidencyValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _currentResidencyValue = newValue!;
                                    state.didChange(newValue);
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
                        name: AppString.enterCode,
                        fullNameController: loginCodeController),
                    CoolTextField(
                        name: AppString.password,
                        fullNameController: passwordController),
                    Container(
                      width: double.infinity,
                      height: 40,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 10),
                      child: TextButton(
                          style: ButtonStyle(
                              //  foregroundColor: AppColor.customPrimaryColor,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: AppColor.primaryColor)))),
                          onPressed: () {},
                          child: const Text(AppString.login,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w800))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppString.forgotCode,
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
