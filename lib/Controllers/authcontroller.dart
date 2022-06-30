import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pak_pharma/Controllers/profilecontroller.dart';
import 'package:pak_pharma/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';
import '../View/Login/login_screen.dart';
import '../View/MainScreen/main_screen.dart';


class AuthController extends GetxController {

   ApiClient api= ApiClient();

Future<void> onInit() async {

  super.onInit();
}
Future getToken() async {
  return prefs!.getString('token');
}

Future getUser() async {
  return prefs!.getString('user');
}

  Future<Widget> checkUserLoggedIn() async {
  bool isLogin = prefs!.get('user') == "null" || prefs!.get('user') == null ? false : true;

    if(isLogin) {
      await ProfileController().initializeUserData();
      return  MainScreen();
    } else {

      return loginScreen();
    }
  }
  
  Future userLogin(String userName,String password,BuildContext context) async {
  Map<String,dynamic> body =  {
    "email":userName,
    "password":password
    };
  print(body.toString());
    Response response = await api.postData("/api/Auth/Login", body);
    if (response.statusCode == 200) {
      print(response.body);
      onLoginSuccess(response.body);
    } else {
      Get.back();
      displayToast("Failed to Log in",null,);
      throw Exception('Failed to login.');

    }
  }

  void onLoginSuccess(Map<String, dynamic> value) async {

    await prefs!.setString('user', jsonEncode(value) );
    await prefs!.setString('token',value["Token"] );
    await ProfileController().initializeUserData();
    // Get.find<DashboardController>().initializeDashboardData();
    Get.to(()=> MainScreen());
  }
  void logout()  {
  prefs!.remove('user');
    prefs!.remove('token');
    Get.offAll(loginScreen());
  }

}
