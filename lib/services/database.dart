import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_here/model/appointment.dart';
import 'package:doctor_here/model/pharmacies.dart';
import 'package:doctor_here/model/user.dart';
import 'package:doctor_here/model/ambulance.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference appointmentCollection =
      Firestore.instance.collection('doctor/ebyD7i0Xqk7joFlqAh0x/patient log');

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference ambulanceCollection =
      Firestore.instance.collection('ambulance');

  final CollectionReference pharmaciesCollection =
      Firestore.instance.collection('pharmacies');

  Future updateAppointmentData(String name, String time, String date) async {
    return await appointmentCollection
        .document(uid)
        .setData({'name': name, 'time': time, 'date': date});
  }

  //  list from snapshot
  List<Appointment> _appointmentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Appointment(
          name: doc.data['name'] ?? '',
          time: doc.data['time'] ?? '0:00AM',
          date: doc.data['date'] ?? '1/1/2020');
    }).toList();
  }

  // Get brews stream
  Stream<List<Appointment>> get appointment {
    return appointmentCollection.snapshots().map(_appointmentListFromSnapshot);
  }

  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(uid: uid, name: snapshot.data['name'], usertype: snapshot.data['user type']);
  // }

  // // Get user document
  // Stream<UserData> get userData {
  //   return userCollection
  //       .document(uid)
  //       .snapshots()
  //       .map(_userDataFromSnapshot);
  // }

  List<Ambulance> _ambulanceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Ambulance(
          name: doc.data['name'] ?? 'XYZ',
          phone: doc.data['phone'] ?? 0000000000,
          pincode: doc.data['date'] ?? 400000);
    }).toList();
  }

  Stream<List<Ambulance>> get ambulance {
    return ambulanceCollection.snapshots().map(_ambulanceListFromSnapshot);
  }

  List<Pharmacies> _pharmaciesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Pharmacies(
          name: doc.data['name'] ?? 'XYZ',
          phone: doc.data['phone'] ?? 0000000000,
          pincode: doc.data['date'] ?? 400000,
          address: doc.data['address'] ?? '',
          timing: doc.data['timing'] ?? '0:00 to 0:00');
    }).toList();
  }

  Stream<List<Pharmacies>> get pharmacies {
    return pharmaciesCollection.snapshots().map(_pharmaciesListFromSnapshot);
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

Future updateUserData(String name, String usertype) async {
  final FirebaseUser user = await auth.currentUser();
  UserData(name: name, uid: user.uid, usertype: usertype);
  return await Firestore.instance
      .collection('users')
      .document(user.uid)
      .setData({'name': name, 'uid': user.uid, 'user type': usertype},
          merge: true);
}

Future<String> userTypeCheck() async {
  final FirebaseUser user = await auth.currentUser();
  var uid = user.uid;
  var x;
  await Firestore.instance
      .collection("users")
      .document("$uid")
      .get()
      .then((value) {
    //print("Hello::" + value.data["user type"]);
    if (value.exists) {
      x = value.data["user type"];
    } else {
      print("No document");
      x = "no";
    }
  });
  return x;
}

Future updateDocData(String name, String phoneno, String speciality,
    String clinicName, String clinicAdd, String clinicTime) async {
  final FirebaseUser user = await auth.currentUser();
  return await Firestore.instance
      .collection('doctor')
      .document(user.uid)
      .setData({
    'name': name,
    'contact no': phoneno,
    'speciality': speciality,
    'clinic name': clinicName,
    'clinic address': clinicAdd,
    'clinic timing': clinicTime
  }, merge: true);
}
// Future<String> userCheck(String uid) async {
//   var exists = 'false';
//   try {
//     await Firestore.instance
//         .collection("users")
//         .where("uid", isEqualTo: "$uid")
//         .getDocuments()
//         .then((doc) {
//       doc.documents.forEach((element) {
//         print(element.data);
//       });
//       if (doc.documents != null) {
//         exists = 'true';
//       } else {
//         exists = 'false';
//       }
//     });
//     return exists;
//   } catch (e) {
//     return 'false';
//   }
// }
