

import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/user.dart';


class ProfileController extends GetxController {
  Rx<User>? usersDtails ;
  User? get userDetail => usersDtails?.value;
  @override
  Future<void> onInit() async {

    await initializeUserData();
    // TODO: implement onInit
    super.onInit();
  }
  Future getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }
  Future<User> initializeUserData() async {
    String json = await getUser();
    //jkashkjflak
    late User user;
    user = User.fromJson(jsonDecode(json));
    print(user.organization.organizationId);
    usersDtails = user.obs;
    refresh();
    update();
    return user;
  }
}