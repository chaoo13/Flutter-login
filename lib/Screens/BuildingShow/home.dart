import 'package:building/Screens/BuildingShow/component/body.dart';
import 'package:building/components/loading.dart';
import 'package:building/model/room.dart';
import 'package:building/model/user.dart';
import 'package:flutter/material.dart';
import 'package:building/services/firestore_database.dart';

class BuidlingShowScreen extends StatelessWidget {
  final MyUser user;
  final Building building;

  const BuidlingShowScreen({Key key, this.user, this.building})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('빌딩(${building.name})'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: StreamBuilder<List<Room>>(
          stream:
              FirebaseService().getRoomList(user.uid, building.bid.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BuildingShowBody(
                  user: user, building: building, rooms: snapshot.data);
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text('No Building');
              } else {
                return Loading();
              }
            }
          }),
    );
  }
}
