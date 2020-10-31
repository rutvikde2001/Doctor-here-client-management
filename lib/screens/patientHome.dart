import 'package:doctor_here/constants/constant.dart';
import 'package:doctor_here/list_creator/ambulancelist_builder.dart';
import 'package:doctor_here/list_creator/cliniclist_builder.dart';
import 'package:doctor_here/list_creator/myappointmentlist_builder.dart';
import 'package:doctor_here/list_creator/pharmacieslist_builder.dart';
import 'package:doctor_here/model/ambulance.dart';
import 'package:doctor_here/model/clinic.dart';
import 'package:doctor_here/model/myappointment.dart';
import 'package:doctor_here/model/pharmacies.dart';
import 'package:doctor_here/screens/CreateAppointment.dart';
import 'package:doctor_here/screens/patientSettings.dart';
import 'package:doctor_here/screens/signin.dart';
import 'package:doctor_here/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
//import 'package:doctor_here/assests/alert.png';
import 'package:doctor_here/services/database.dart';

class PtHome extends StatefulWidget {
  final Function toggleView;
  PtHome({this.toggleView});
  @override
  _MyPtHomePage createState() => _MyPtHomePage();
}

class _MyPtHomePage extends State<PtHome> {
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 4,
            child: StreamProvider<List<Clinic>>.value(
              value: DatabaseService().clinic,
              child: StreamProvider<List<MyAppointment>>.value(
                value: DatabaseService().myappointment,
                child: StreamProvider<List<Ambulance>>.value(
                  value: DatabaseService().ambulance,
                  child: StreamProvider<List<Pharmacies>>.value(
                    value: DatabaseService().pharmacies,
                    child: Scaffold(
                      backgroundColor: Colors.grey[200],
                      appBar: GradientAppBar(
                        backgroundColorStart: Colors.blue[900],
                        backgroundColorEnd: Colors.blue[500],
                        title: Text('Doctor Here'),
                        centerTitle: true,
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              print("search");
                              signOutGoogle();
                              signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                          ),
                          PopupMenuButton<String>(
                            onSelected: choiceAction,
                            itemBuilder: (BuildContext context) {
                              return Constants.choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  child: Text(choice),
                                  value: choice,
                                );
                              }).toList();
                            },
                          )
                        ],
                        bottom: TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(
                              child: Text("Clinics"),
                            ),
                            Tab(
                              child: Text("Your Appointments"),
                            ),
                            Tab(
                              child: Text("Pharmacies"),
                            ),
                            Tab(
                              child: Icon(
                                Icons.local_hospital,
                                color: Colors.red[500],
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: <Widget>[
                          ClinicList(),
                          MyAppointmentList(),
                          PharmaciesList(),
                          AmbulanceList(),
                        ],
                      ),
                      // floatingActionButton: FloatingActionButton(
                      //   onPressed: () {
                      //     // Add your onPressed code here!
                      //     print("new appointment");
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => CreateAppointment()));
                      //   },
                      //   child: Container(
                      //     width: 60,
                      //     height: 60,
                      //     child: Icon(
                      //       Icons.add,
                      //       size: 40,
                      //     ),
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         gradient: LinearGradient(
                      //             colors: [Colors.blue[500], Colors.blue[900]])),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),
            ))); //,
    //);

    //),
    //);
  }

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      print("Settings");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PatSetting()));
    } else if (choice == Constants.Location) {
      print("Location");
    } else if (choice == Constants.Notifications) {
      print("Notification");
    }
  }
}
