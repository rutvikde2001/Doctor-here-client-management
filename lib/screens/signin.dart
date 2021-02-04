//import 'package:doctor_here/model/user.dart';
import 'package:doctor_here/screens/Register/ask.dart';
import 'package:doctor_here/screens/doctorHome.dart';
import 'package:doctor_here/screens/patientHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:doctor_here/services/auth.dart';
import 'dart:async';
import 'package:doctor_here/services/database.dart';

/// This Widget is the main application widget.
class SignIn extends StatelessWidget {
  static const String _title = 'Doctor Here';
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  // ignore: missing_return
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          //Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;
          var check = await userTypeCheck();
          if (user != null) {
            // ignore: unrelated_type_equality_checks
            if (check == 'doctor') {
              getUid();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => DrHome()));
              // ignore: unrelated_type_equality_checks
            } else if (check == "patient") {
              getUid();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => PtHome()));
              // ignore: unrelated_type_equality_checks
            } else if (check == "no") {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Ask()));
            }
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(
              "$exception verification failed ${exception.code}. Message: ${exception.message}");
          AlertDialog(title: Text("Invalide verification code"));
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter OTP: "),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;
                        var check = userTypeCheck();
                        if (user != null) {
                          // ignore: unrelated_type_equality_checks
                          if (check == "no") {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Ask()));
                            // ignore: unrelated_type_equality_checks
                          } else if (check == "patient") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PtHome()));
                            // ignore: unrelated_type_equality_checks
                          } else if (check == "doctor") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DrHome()));
                          }
                        } else {
                          print("Error");
                          AlertDialog(
                              title: Text("Invalide verification code"));
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: GradientAppBar(
          backgroundColorStart: Colors.blue[900],
          backgroundColorEnd: Colors.blue[500],
          title: Text('Doctor Here'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    controller: _phoneController,
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[500], Colors.blue[900]],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),
                ),
                child: FlatButton(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final phone = "+91" + _phoneController.text.trim();

                    loginUser(phone, context);
                  },
                ),
              ),
              SizedBox(
                height: 60,
              ),
              SignInButton(
                Buttons.GoogleDark,
                text: "Sign up with Google",
                onPressed: () {
                  signInWithGoogle().whenComplete(() async {
                    bool signin = await signInWithGoogle();
                    //print(signin);
                    var check = await userTypeCheck();
                    if (signin) {
                      //print(check);
                      // ignore: unrelated_type_equality_checks
                      if (check == "no") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Ask()));
                        //print("3");
                        // ignore: unrelated_type_equality_checks
                      } else if (check == "patient") {
                        getUid();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => PtHome()));
                        //print("2");
                      } else if (check == "doctor") {
                        getUid();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => DrHome()));
                        //print("1");
                      }
                    }
                  });
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
