import 'package:flutter/material.dart';
import 'package:doctor_here/model/appointment.dart';
import 'package:intl/intl.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  AppointmentTile({this.appointment});
  @override
  Widget build(BuildContext context) {
    var date = appointment.date;
    var name = appointment.name.toUpperCase().split(" ");
    var n = name[0].split('');
    var s = name[1].split('');
    var now = DateTime.now();
    String today = DateFormat('dd/MM/yyyy').format(now);
    if (date == today) {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey,
              child:
                  Text(n[0] + s[0], style: TextStyle(color: Colors.lightBlue)),
            ),
            title:
                Text(appointment.name, style: TextStyle(color: Colors.black)),
            subtitle: Text('Time: ' + appointment.time + ' Date:' + date,
                style: TextStyle(color: Colors.black)),
            onTap: () {
              print("${appointment.name}");
            },
          ),
        ),
      );
    } else {
      return Container(
        width: 1,
        height: 1,
      );
    }
  }
}
