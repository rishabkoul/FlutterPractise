import 'package:flutter/material.dart';
import 'package:hello_world/pages/home_page_with_fb.dart';
import 'package:hello_world/pages/login_page.dart';
import 'package:hello_world/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Awesome App",
      home: Constants.prefs.getBool("LoggedIn") == true
          ? HomePageFB()
          : LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routes: {
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePageFB(),
      }));
}
