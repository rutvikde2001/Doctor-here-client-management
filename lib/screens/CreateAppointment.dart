import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class CreateAppointment extends StatefulWidget {
  @override
  _CreateAppointmentState createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  String patName = '';
  String number = '';
  String remarks = '';

  DateTime pickedDate;
  TimeOfDay time;
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }
   _pickDate() async {
      DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 2),
        initialDate: pickedDate,
      );
      if (date != null)
        setState(() {
          pickedDate = date;
        });
    }

    _pickTime() async {
      TimeOfDay t = await showTimePicker(context: context, initialTime: time);
      if (t != null)
        setState(() {
          time = t;
        });
    }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: GradientAppBar(
        backgroundColorStart: Colors.blue[900],
        backgroundColorEnd: Colors.blue[500],
        title: Text('Create Appointment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) {
                    patName = val;
                    return ("$patName");
                  },
                  decoration: InputDecoration(labelText: 'Enter Patient Name'),
                ),
                SizedBox(height: 20.0),
                // TextFormField(
                //   onChanged: (val){
                //     timeSlot = val;
                //     return("$timeSlot");
                //   },
                //   decoration: InputDecoration(
                //       labelText: 'Enter Timeslot'
                //   ),
                // ),
                
                TextFormField(
                  onChanged: (val) {
                    number = val;
                    return ('$number');
                  },
                  decoration:
                      InputDecoration(labelText: 'Enter Contact Number'),
                ),
                SizedBox(height: 20.0),
                ListTile(
                  title: Text(
                      "Select Date: ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickDate,
                ),
                SizedBox(height: 20.0),
                ListTile(
                  title: Text(" Select Time: ${time.hour}:${time.minute}"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  
                  onTap: _pickTime,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) {
                    remarks = val;
                    return ("$remarks");
                  },
                  decoration: InputDecoration(labelText: 'Remarks'),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
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
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
   
  }
}
