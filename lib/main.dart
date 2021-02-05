//import 'package:doctor_here/login.dart';
//import 'package:doctor_here/screens/Register/MoreinfoDoc.dart';
//import 'package:doctor_here/screens/Register/ask.dart';
import 'package:doctor_here/screens/signin.dart';
import 'package:doctor_here/screens/patientHome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctor_here/screens/doctorHome.dart';

void main() => runApp(MyApp());

var type, isloggedin, uid;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
          var x = prefs.data;
          if (prefs.hasData) {
            if (x.getBool('isloggedin')) {
              if (x.getString('type') == 'doctor') {
                return MaterialApp(home: DrHome());
              } else
                return MaterialApp(home: PtHome());
            }
          }

          return MaterialApp(home: SignIn());
        });
  }
}
