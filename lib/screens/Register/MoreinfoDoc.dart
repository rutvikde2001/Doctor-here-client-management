import 'package:doctor_here/model/user.dart';
import 'package:doctor_here/screens/doctorHome.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:doctor_here/services/database.dart';

class MoreInfoDoc extends StatefulWidget {
  @override
  _MoreInfoDocState createState() => _MoreInfoDocState();
}

class _MoreInfoDocState extends State<MoreInfoDoc> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _clinicName = TextEditingController();
  final _specialty = TextEditingController();
  final _clinicAddress = TextEditingController();
  final _clinicTimings = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: GradientAppBar(
        backgroundColorStart: Colors.blue[900],
        backgroundColorEnd: Colors.blue[500],
        title: Text('More Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Text(
                  'Doctor Info',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Enter Full Name'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Enter Contact No.'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _specialty,
                  decoration: InputDecoration(labelText: 'Enter Specialty'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _clinicName,
                  decoration: InputDecoration(labelText: 'Enter Clinic Name'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _clinicAddress,
                  decoration:
                      InputDecoration(labelText: 'Enter Clinic Address'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _clinicTimings,
                  decoration:
                      InputDecoration(labelText: 'Enter Clinic Timings'),
                ),
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
                    onPressed: () async {
                      UserData(name: _nameController.text);
                      await updateUserData(_nameController.text, "doctor")
                          .then((value) async {
                        await updateDocData(
                                _nameController.text,
                                _phoneController.text,
                                _specialty.text,
                                _clinicName.text,
                                _clinicAddress.text,
                                _clinicTimings.text)
                            .then((value) {
                              Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => DrHome()));
                            });
                      });
                    },
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
