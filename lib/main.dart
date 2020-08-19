//import 'package:doctor_here/login.dart';
import 'package:doctor_here/screens/signin.dart';
//import 'package:doctor_here/screens/patientHome.dart';
import 'package:flutter/material.dart';
//import 'package:doctor_here/screens/doctorHome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(), //PtHome(),
    );
  }
}
