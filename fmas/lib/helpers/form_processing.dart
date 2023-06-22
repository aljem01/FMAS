// ignore_for_file: prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fma_project/helpers/check_session.dart';
import '../helpers/routes.dart';
import 'package:http/http.dart' as http;

class ProcessForm {
  void getData(json, account, context) async {
    try {
      final httpPackageInfo = await http
          .read(Uri.parse("https://agrox.farm/fmas/get_employees/" + json));
      if (httpPackageInfo.contains("success")) {
        var resturnStr = httpPackageInfo.split("-");
        var id = resturnStr[0];
        AndroidOptions _getAndroidOptions() => const AndroidOptions(
              encryptedSharedPreferences: true,
            );
        final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

        await storage.write(key: 'loggedInUser', value: id);
        final userDetails = await http
            .read(Uri.parse("https://agrox.farm/fmas/get_user_details/$id"));
        await storage.write(key: 'loggedInUserDetails', value: userDetails);

        final checkUserSession = CheckSession();
        checkUserSession.checkSessionInfo(context);
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
      print(e);
    }
  }

  void getDataRegisterFamily(json, account, context) async {
    try {
      final httpPackageInfo = await http
          .read(Uri.parse("https://agrox.farm/fmas/get_employees/" + json));
      if (httpPackageInfo.contains("success")) {
        Fluttertoast.showToast(
            msg: "You have successfully registered a family member",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(0, 255, 0, 0.8),
            textColor: Colors.white,
            fontSize: 16.0);
        final checkUserSession = CheckSession();
        checkUserSession.checkSessionInfo(context);
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
    } catch (e) {
      print(e);
    }
  }
}
