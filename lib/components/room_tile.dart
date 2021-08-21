import 'package:building/model/room.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class RoomTile extends StatefulWidget {
  Room roomInfo;
  int numOfFloors;
  Function setRoomInfo;
  RoomTile({this.roomInfo, this.numOfFloors, this.setRoomInfo});
  @override
  _RoomTileState createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            children: <Widget>[
              Text('방 이름'),
              Container(
                width: size.width * 0.3,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  // maxLength: 20,
                  initialValue: widget.roomInfo.name,
                  onChanged: (val) {
                    if (val != null) {
                      widget.roomInfo.name = val;
                      widget.setRoomInfo(widget.roomInfo);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: '방 이름',
                    // border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              // Group
              Text('층'),
              SizedBox(
                width: 20,
              ),
              OutlinedButton(
                child: Text('${widget.roomInfo.groupId} 층'),
                onPressed: () => _showIntegerDialog(1, widget.numOfFloors,
                    widget.roomInfo.groupId, "층 선택", _handleFloorCountChanged),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
              ),
            ],
          )),
    );
  }

  _handleFloorCountChanged(int value) {
    if (value != null) {
      setState(() {
        print(value);
        widget.roomInfo.groupId = value;
      });
      widget.setRoomInfo(widget.roomInfo);
    }
  }

  Future _showIntegerDialog(int minValue, int maxValue, int initValue,
      String title, Function handleValueChanged) async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
              minValue: minValue,
              maxValue: maxValue,
              initialIntegerValue: initValue,
              title: Text(title));
        }).then(handleValueChanged);
  }
}
