import 'package:doctor_here/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
//import 'package:provider/provider.dart';
//import 'package:doctor_here/assests/alert.png';
//import 'package:doctor_here/services/database.dart';

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
        //child: StreamProvider<List<Appointment>>.value(
        //value: null, //DatabaseService().appointment,
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
              Center(
                child: Text(
                  "No Result",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 30,
                  ),
                ),
              ),
              Text("data"),
              Text("data"),
              Text("data"),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              print("new appointment");
            },
            child: Container(
              width: 60,
              height: 60,
              child: Icon(
                Icons.add,
                size: 40,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.blue[500], Colors.blue[900]])),
            ),
          ),
        ),
      ),
    ); //,
    //);

    //),
    //);
  }

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      print("Settings");
    } else if (choice == Constants.Location) {
      print("Location");
    } else if (choice == Constants.Notifications) {
      print("Notification");
    }
  }
}
