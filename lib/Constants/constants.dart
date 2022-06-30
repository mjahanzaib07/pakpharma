import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const primaryColor = Color(0xFF6FB7F1);
const primarydark = Color(0xFF1052a3);
const secondaryColor = Color(0xFFE6E9EA);
const secondaryGreen = Color(0xFF4bd9a4);
const teritoriColor = Color(0xFF73a2e1);
const bgColor = Color(0xFFf8fbff);

const defaultPadding = 16.0;
displayToast(String message,BuildContext? context,){
  Get.snackbar(message, "",snackPosition:SnackPosition.BOTTOM,);
}



String formatnmbr(double n){
  var formatter = NumberFormat('#,##,000');
  String nmbr = formatter.format(n.toInt());
  return nmbr;
}

const String baseUrl = "https://pharmaapitest.azurewebsites.net/";
SharedPreferences? prefs;