import 'package:building/Screens/BuildingShow/component/background.dart';
import 'package:building/components/room_card.dart';
import 'package:building/model/room.dart';
import 'package:building/model/user.dart';
import 'package:building/services/firestore_database.dart';
import 'package:flutter/material.dart';

class BuildingShowBody extends StatefulWidget {
  final MyUser user;
  final Building building;
  final List<Room> rooms;

  const BuildingShowBody({Key key, this.user, this.building, this.rooms})
      : super(key: key);
  @override
  _BuildingShowBodyState createState() => _BuildingShowBodyState();
}

class _BuildingShowBodyState extends State<BuildingShowBody> {
  List<Widget> occupiedRoomCardList;
  List<Widget> emptyRoomCardList;

  @override
  Widget build(BuildContext context) {
    occupiedRoomCardList = new List<Widget>();
    emptyRoomCardList = new List<Widget>();
    Size size = MediaQuery.of(context).size;
    occupiedRoomCardList = new List<Widget>();
    widget.rooms.forEach((element) {
      if (element.contractId == null) {
        emptyRoomCardList.add(RoomCard(
          user: widget.user,
          room: element,
          building: widget.building,
        ));
      } else {
        occupiedRoomCardList.add(RoomCard(
          user: widget.user,
          room: element,
          building: widget.building,
        ));
      }
    });

    return Background(
      child: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      '빈방 목록',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              emptyRoomCardList.isNotEmpty
                  ? GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      childAspectRatio: 8.0 / 6.5,
                      children: emptyRoomCardList,
                    )
                  : Text('빈방이 없습니다.'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      '계약된 방 목록',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              occupiedRoomCardList.isNotEmpty
                  ? GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      childAspectRatio: 8.0 / 6.5,
                      children: occupiedRoomCardList,
                    )
                  : Text('계약된 방이 없습니다.'),
            ],
          ),
        ),
      ),
    );
  }
}
