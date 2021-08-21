import 'package:building/Screens/Building/component/body.dart';
import 'package:building/model/user.dart';
import 'package:flutter/material.dart';

class BuildingAdd extends StatelessWidget {
  final MyUser user;

  const BuildingAdd({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add New Building'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: BuildingBody(user: user),
    );
  }
}
