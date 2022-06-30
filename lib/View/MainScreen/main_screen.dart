import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pak_pharma/Constants/constants.dart';
import 'package:pak_pharma/Controllers/authcontroller.dart';
import 'package:pak_pharma/Controllers/profilecontroller.dart';
import 'package:pak_pharma/View/Accounts/accounnts_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  var profilecont = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Text(
                          "Welcome ${profilecont.userDetail?.name}" ?? "N/A",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: primarydark),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AuthController().logout();
                    },
                    child: Card(
                      elevation: 1,
                      color: bgColor,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: const [
                            Text(
                              "Logout",
                              style: TextStyle(color: primarydark),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.logout,
                              size: 20,
                              color: primarydark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              Expanded(
                  child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap:(){
                      Get.to(()=> AccountScreen());
                    },
                    child: Card(
                      color: bgColor,
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.account_balance,
                            color: secondaryGreen,
                            size: 70,
                          ),
                          Text(
                            "Accounts",
                            style: TextStyle(
                                color: secondaryGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: bgColor,
                    elevation: 2,
                    child: SizedBox(
                      height: 100,
                      width: Get.width - 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.pie_chart,
                            color: primarydark,
                            size: 70,
                          ),
                          Text(
                            "OverView",
                            style: TextStyle(
                                color: primarydark,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: bgColor,
                    elevation: 2,
                    child: SizedBox(
                      height: 100,
                      width: Get.width - 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.calendar_month,
                            color: primarydark,
                            size: 70,
                          ),
                          Text(
                            "Schedules",
                            style: TextStyle(
                                color: primarydark,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: bgColor,
                    elevation: 2,
                    child: SizedBox(
                      height: 100,
                      width: Get.width - 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.leaderboard,
                            color: secondaryGreen,
                            size: 70,
                          ),
                          Text(
                            "Records",
                            style: TextStyle(
                                color: secondaryGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              )

                  ),
              const Divider(color: Colors.grey,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Powered by Aiksol.",style: TextStyle(fontSize: 12),),
                  SizedBox(width: 10,),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/images/aiksol2.png"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
