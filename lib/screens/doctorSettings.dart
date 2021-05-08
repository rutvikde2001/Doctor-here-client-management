import 'package:doctor_here/screens/Register/MoreinfoDoc.dart';
import 'package:doctor_here/screens/signin.dart';
import 'package:doctor_here/services/auth.dart';
import 'package:flutter/material.dart';

class DrSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: const EdgeInsets.all(8.00),
          child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Edit profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              trailing: Icon(Icons.edit),
              onTap: () {
                print('edit');
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoreInfoDoc()));
              })),
      const SizedBox(height: 8.00),
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              title: Text("About Developers"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // About Developer Info
              },
            )
          ])),
      const SizedBox(height: 8.00),
      Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.00)),
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              title: Text("Log Out"),
              trailing: Icon(Icons.logout),
              onTap: () {
                // About Developer Info
                signOutGoogle();
                signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
            )
          ]))
    ]));
  }
}
