import 'package:building/Screens/Contract/components/body_view.dart';
import 'package:building/Screens/Contract/home.dart';
import 'package:building/constants.dart';
import 'package:building/model/room.dart';
import 'package:building/model/user.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final MyUser user;
  final Room room;
  final Building building;

  const RoomCard({Key key, this.user, this.room, this.building})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: room.contractId == null
                  ? Icon(Icons.house_outlined, size: 60)
                  : Icon(Icons.home_sharp, size: 60),
              title: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(room.name,
                      style: TextStyle(color: Colors.black, fontSize: 25.0))),
              subtitle: Text('빈방',
                  style: TextStyle(color: Colors.black, fontSize: 15.0)),
            ),
            Center(
                child: room.contractId == null
                    ? FlatButton(
                        child: const Text('신규 입실 등록',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ContractAddScreen(
                                  user: user,
                                  room: room,
                                  building: building,
                                );
                              },
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: kPrimaryColor,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(30)),
                      )
                    : FlatButton(
                        child: const Text('입실 정보 확인',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ContractResultScreen(
                                    user: user,
                                    building: building,
                                    cid: room.contractId,
                                    room: room,
                                    toModify: false);
                              },
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: kPrimaryColor,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(30)),
                      )),
          ],
        ),
      ),
    );
  }
}
