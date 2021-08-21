import 'package:building/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class BuildingTile extends StatefulWidget {
  // String name;
  final Function setBuildingName;
  final Function setNumOfRooms;
  final int numOfRooms;
  final Function setNumOfFloors;
  final int numOfFloors;
  BuildingTile(
      {this.setBuildingName,
      this.setNumOfRooms,
      this.numOfRooms,
      this.setNumOfFloors,
      this.numOfFloors});
  @override
  _BuildingTileState createState() => _BuildingTileState();
}

class _BuildingTileState extends State<BuildingTile> {
  // NumberPicker roomNumberPicker;

  _handleRoomCountChanged(int value) {
    if (value != null) {
      widget.setNumOfRooms(value);
    }
  }

  _handleFloorCountChanged(int value) {
    if (value != null) {
      widget.setNumOfFloors(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    // margin: EdgeInsets.all(10),
                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      onChanged: (val) {
                        widget.setBuildingName(val);
                      },
                      decoration: InputDecoration(
                        hintText: '건물 이름',
                        // border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    // margin: ,
                    child: CircleAvatar(
                      maxRadius: 25,
                      minRadius: 20,
                      // radius: 22,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: FlatButton(
                      onPressed: () => _showIntegerDialog(1, 50,
                          widget.numOfRooms, '방 갯수', _handleRoomCountChanged),
                      child: Text('방 갯수'),
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text('${widget.numOfRooms} 개')),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: FlatButton(
                      onPressed: () => _showIntegerDialog(1, 10,
                          widget.numOfFloors, '층 수', _handleFloorCountChanged),
                      child: Text('층 수'),
                      color: Colors.red[200],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text('${widget.numOfFloors} 개')),
                ],
              )
            ],
          )),
    );
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
