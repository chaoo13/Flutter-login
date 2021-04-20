import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseService();

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference buildingCollection =
      FirebaseFirestore.instance.collection('building');

  Future updateUserDate(String uid, String email) async {
    await usersCollection.doc(uid).set({'email': email});
  }
}
