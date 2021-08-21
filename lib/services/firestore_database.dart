import 'package:building/model/contract.dart';
import 'package:building/model/person.dart';
import 'package:building/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  FirebaseService();

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference buildingCollection =
      FirebaseFirestore.instance.collection('building');

  final CollectionReference contractCollection =
      FirebaseFirestore.instance.collection('contract');

  final CollectionReference guestCollection =
      FirebaseFirestore.instance.collection('guest');

  Future updateUserDate(String uid, String email) async {
    await usersCollection.doc(uid).set({'email': email});
  }

  Future updateContractData(String uid, String bid, Contract contract) async {
    contractCollection
        .doc(uid)
        .collection('buildings')
        .doc(bid)
        .collection('contracts')
        .doc(contract.cid.toString())
          ..set(contract.toMap());
  }

  Future updateBuildingData(String uid, Building building) async {
    usersCollection
        .doc(uid)
        .collection('buildings')
        .doc(building.bid.toString())
          ..set(building.toMap());
    if (building.rooms != null && building.rooms.length > 0) {
      return building.rooms.forEach((room) => usersCollection
          .doc(uid)
          .collection('buildings')
          .doc(building.bid.toString())
          .collection('rooms')
          .doc(room.rid.toString())
            ..set(room.toMap()));
    }
  }

  Future updateGuestData(String uid, Person guest) async {
    guestCollection.doc(uid).collection('guest').doc(guest.pid.toString())
      ..set(guest.toMap());
  }

  Future occupyRoomData(String uid, String bid, Room room) async {
    usersCollection
        .doc(uid)
        .collection('buildings')
        .doc(bid)
        .collection('rooms')
        .doc(room.rid.toString())
          ..set(room.toMap());
  }

  Stream<List<Room>> getRoomList(String uid, String bid) {
    print("bid : ${bid}");
    return usersCollection
        .doc(uid)
        .collection('buildings')
        .doc(bid)
        .collection('rooms')
        .snapshots()
        .map(_getRooms);
  }

  Stream<List<Building>> getBuildingList(String uid) {
    return usersCollection
        .doc(uid)
        .collection('buildings')
        .snapshots()
        .map(_getBuildings);
  }

  Stream<List<Person>> getGuestList(String uid) {
    return guestCollection
        .doc(uid)
        .collection('guest')
        .snapshots()
        .map(_getGuests);
  }

  Future<List<Person>> getGuestListOnce(String uid) async {
    return guestCollection
        .doc(uid)
        .collection('guest')
        .get()
        .then((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) => Person.fromJson(doc.data())).toList();
    });
  }

  List<Person> _getGuests(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Person.fromJson(doc.data())).toList();
    // return snapshot.docs.map((doc) {
    //   return Person(
    //     pid: doc.data()['pid'],
    //     name: doc.data()['name'],
    //     phoneNumber: doc.data()['phoneNumber'],
    //   );
    // }).toList();
  }

  Future<Contract> getContract(String uid, String bid, String cid) async {
    // print("uid: ${uid}, bid: ${bid}, cid: ${cid}");
    return contractCollection
        .doc(uid)
        .collection('buildings')
        .doc(bid)
        .collection('contracts')
        .doc(cid)
        .get()
        .then(
            (DocumentSnapshot snapshot) => Contract.fromJson(snapshot.data()));
  }

  Future<Person> getGuest(String uid, String pid) async {
    return guestCollection
        .doc(uid)
        .collection('guest')
        .doc(pid)
        .get()
        .then((DocumentSnapshot snapshot) => Person.fromJson(snapshot.data()));

    //   return Person(
    //       pid: snapshot.data()['pid'],
    //       name: snapshot.data()['name'],
    //       phoneNumber: snapshot.data()['phoneNumber'],
    //       postcode: snapshot.data()['postcode'],
    //       birthday: DateTime.parse(snapshot.data()['birthday']),
    //       encSocialNumber: snapshot.data()['encSocialNumber'],
    //       addressMain: snapshot.data()['addressMain'] ?? "",
    //       addressDetail: snapshot.data()['addressDetail'] ?? "",
    //       gender: snapshot.data()['gender'],
    //       job: snapshot.data()['job'],
    //       jobName: snapshot.data()['jobName'] ?? "",
    //       relateName: snapshot.data()['relationName'] ?? "",
    //       relateRelation: snapshot.data()['relateRelation'],
    //       relatePhoneNumber: snapshot.data()['relationPhoneNumber'],
    //       memo: snapshot.data()['memo']);
    // });
  }

  List<Building> _getBuildings(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Building(
        name: doc.data()['name'],
        bid: doc.data()['bid'],
      );
    }).toList();
  }

  List<Room> _getRooms(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Room(
          rid: doc.data()['rid'],
          name: doc.data()['name'],
          groupId: doc.data()['groupId'],
          contractId: doc.data()['contractId']);
    }).toList();
  }
}
