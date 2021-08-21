import 'package:building/Screens/Home/components/background.dart';
import 'package:building/components/building_card.dart';
import 'package:building/model/room.dart';
import 'package:building/model/user.dart';
import 'package:building/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class HomeBody extends StatefulWidget {
  final List<Building> buildings;
  final MyUser user;
  const HomeBody({Key key, this.buildings, this.user}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Widget> buildingCardList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      print('keyboard : ${visible.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.buildings != null) {
      if (widget.buildings.isNotEmpty) {
        buildingCardList = new List<Widget>();
        widget.buildings.forEach((element) {
          buildingCardList.add(StreamBuilder<List<Room>>(
              stream: FirebaseService()
                  .getRoomList(widget.user.uid, element.bid.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  element.rooms = snapshot.data;
                } else {
                  element.rooms = [];
                }
                return BuildingCard(
                  user: widget.user,
                  building: element,
                );
              }));
        });
      }
    }

    return Background(
      child: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                children: [
                  Text(
                    '건물 목록',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            buildingCardList != null
                ? GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    childAspectRatio: 8.0 / 9.0,
                    children: buildingCardList,
                  )
                : Text('No Building')
          ],
        ),
      ),
    );
  }
}
