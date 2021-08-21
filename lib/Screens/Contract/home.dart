import 'package:building/Screens/Contract/components/body.dart';
import 'package:building/model/room.dart';
import 'package:building/model/user.dart';
import 'package:flutter/material.dart';

class ContractAddScreen extends StatelessWidget {
  final MyUser user;
  final Room room;
  final Building building;

  const ContractAddScreen({Key key, this.user, this.room, this.building})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('입실 등록 (${room.name})'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: ContractBody(
          user: user,
          room: room,
          building: building,
        ));
  }
}
