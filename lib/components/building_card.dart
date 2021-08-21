import 'package:building/Screens/BuildingShow/home.dart';
import 'package:building/model/user.dart';
import 'package:flutter/material.dart';
import 'package:building/model/room.dart';

class BuildingCard extends StatelessWidget {
  final Building building;
  final MyUser user;
  const BuildingCard({
    Key key,
    this.building,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numOfRooms = building.rooms.length;
    int numOfEmptyRooms =
        building.rooms.where((element) => element.contractId == null).length;

    return GestureDetector(
      onTap: () {
        print("ssdsd");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BuidlingShowScreen(user: user, building: building);
            },
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Image.asset(
                'assets/images/default_building.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      building.name,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('공실 ( ${numOfEmptyRooms} / ${numOfRooms} )',
                        style: TextStyle(color: Colors.black, fontSize: 15.0))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
