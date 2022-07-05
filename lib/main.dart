import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pak_pharma/Controllers/coa_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/constants.dart';
import 'Constants/loading_widget.dart';
import 'Controllers/authcontroller.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pak Pharma',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).primaryTextTheme).apply(),
        primaryColor: primaryColor,
        cardColor: bgColor,
        canvasColor: secondaryColor,
      ),

      home: FutureBuilder(
        future: AuthController().checkUserLoggedIn(),
        builder: (context, dynamic snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          }
          return const Center(child: LoadingWidget());
        },
      ),
    );
  }
}


