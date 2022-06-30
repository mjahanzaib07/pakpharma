

import 'package:get/get.dart';
import 'package:pak_pharma/Constants/constants.dart';

import '../Controllers/authcontroller.dart';
import '../View/Login/login_screen.dart';


class ApiChecker {

  var auth = Get.put(AuthController());
   void checkApi(Response response) {
    if(response.statusCode == 401||response.statusCode == 403) {
      auth.logout();

      Get.offAll(loginScreen());
    }else {
      print("Api Response"+response.statusCode.toString());
    }
  }
}