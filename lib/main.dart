import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
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
      title: 'Work-313 Administration Dashboard Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).apply(),
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


