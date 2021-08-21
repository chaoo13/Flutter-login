import 'dart:math';

import 'package:building/components/background.dart';
import 'package:building/components/building_tile.dart';
import 'package:building/components/room_tile.dart';
import 'package:building/components/rounded_button.dart';
import 'package:building/model/user.dart';
import 'package:building/services/auth.dart';
import 'package:building/services/firestore_database.dart';
import 'package:building/model/room.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildingBody extends StatefulWidget {
  final MyUser user;

  const BuildingBody({Key key, this.user}) : super(key: key);
  @override
  _BuildingBodyState createState() => _BuildingBodyState();
}

class _BuildingBodyState extends State<BuildingBody> {
  String buildingName;
  int numOfRooms = 1;
  int numOfFloors = 1;
  List<Room> rooms;

  void setRooms() {
    rooms = new List<Room>();
    for (int i = 0; i < numOfRooms; i++) {
      rooms.add(new Room(rid: i, groupId: 1, name: i.toString() + ' 호'));
    }
  }

  void setNumOfFloors(int numOfFloors) {
    setState(() {
      this.numOfFloors = numOfFloors;
    });
    setRooms();
  }

  void setNumOfRooms(int numOfRooms) {
    setState(() {
      this.numOfRooms = numOfRooms;
    });
    setRooms();
  }

  void setBuildingName(String buildingName) {
    this.buildingName = buildingName;
  }

  void setRoomInfo(Room newRoomInfo) {
    setState(() {
      int i = rooms.indexWhere((element) => element.rid == newRoomInfo.rid);
      rooms[i].groupId = newRoomInfo.groupId;
      rooms[i].name = newRoomInfo.name;
      print('setRoomInfo ${i} ${newRoomInfo.rid} ${newRoomInfo.groupId}');
    });
    rooms.forEach((element) => print(
        'setRoomInfo ${element.rid} ${element.name} ${newRoomInfo.groupId}'));
  }

  final AuthService _auth = AuthService();
  @override
  void initState() {
    setRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  BuildingTile(
                      setBuildingName: this.setBuildingName,
                      setNumOfRooms: this.setNumOfRooms,
                      numOfRooms: this.numOfRooms,
                      setNumOfFloors: this.setNumOfFloors,
                      numOfFloors: this.numOfFloors),
                  Column(
                    children: _showRoomTile(),
                  )
                ],
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                      child: RoundedButton(
                          text: 'Save',
                          press: () {
                            print(this.buildingName);
                            if (this.buildingName == null ||
                                this.buildingName.length < 1) {
                              setBuildingName(
                                  "building${Random().nextInt(100)}");
                            }
                            FirebaseService().updateBuildingData(
                                widget.user.uid,
                                Building(
                                    bid: DateTime.now().millisecondsSinceEpoch,
                                    name: this.buildingName,
                                    rooms: rooms));

                            Navigator.pop(context);
                          }))
                ])
          ],
        ),
      ),
    );
  }

  List<Widget> _showRoomTile() {
    if (rooms.isNotEmpty) {
      return rooms
          .map((roomInfo) => new RoomTile(
              roomInfo: roomInfo,
              numOfFloors: numOfFloors,
              setRoomInfo: setRoomInfo))
          .toList();
    }
  }
}
