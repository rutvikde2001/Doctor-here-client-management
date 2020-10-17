import 'package:flutter/material.dart';
import 'package:doctor_here/model/appointment.dart';
//import 'package:intl/intl.dart';

class PatientLogTile extends StatelessWidget {
  final Appointment patientlog;
  PatientLogTile({this.patientlog});
  @override
  Widget build(BuildContext context) {
    var date = patientlog.date;
    var name = patientlog.name.split(" ");
    var n = name[0];
    var sur;
    n.split('');
    var s;
    if (name.length != 0) {
      s = name[1];
      s.split('');
      sur = s[0];
    } else {
      s = '';
      sur = s;
    }
    //var now = DateTime.now();
    //String today = DateFormat('dd/MM/yyyy').format(now);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blueGrey,
            child: Text("${n[0]}$sur",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          ),
          title: Text(patientlog.name, style: TextStyle(color: Colors.black)),
          subtitle: Text('Time: ' + patientlog.time + ' Date:' + date,
              style: TextStyle(color: Colors.black)),
          onTap: () {
            print("${patientlog.name}");
          },
        ),
      ),
    );
  }
}
