import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_here/model/appointment.dart';
import 'package:doctor_here/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference appointmentCollection =
      Firestore.instance.collection('doctor/ebyD7i0Xqk7joFlqAh0x/patient log');

  Future updateUserData(String name, String time, String date) async {
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

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, name: snapshot.data['name']);
  }

  // Get user document
  Stream<UserData> get userData {
    return appointmentCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
