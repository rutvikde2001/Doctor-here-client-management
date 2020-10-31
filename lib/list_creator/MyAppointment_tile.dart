import 'package:flutter/material.dart';
import 'package:doctor_here/model/myappointment.dart';
//import 'package:intl/intl.dart';

class MyAppointmentTile extends StatelessWidget {
  final MyAppointment myappointment;
  MyAppointmentTile({this.myappointment});
  @override
  Widget build(BuildContext context) {
    var date = myappointment.date;
    var name = myappointment.name.toUpperCase().split(" ");
    var n = '';
    try {
      n = name[0].substring(0, 1) + name[1].substring(0, 1);
    } catch (Exception) {
      n = name[0].substring(0, 1);
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.grey,
            child: Text(n, style: TextStyle(color: Colors.lightBlue)),
          ),
          title: Text(myappointment.drname + " : " + myappointment.name,
              style: TextStyle(color: Colors.black)),
          subtitle: Text('Time: ' + myappointment.time + ' Date:' + date,
              style: TextStyle(color: Colors.black)),
          onTap: () {
            print("${myappointment.name}");
          },
        ),
      ),
    );
  }
}