import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class RoomCountPicker extends StatelessWidget {
  final int initValue;
  final Function onChanged;

  const RoomCountPicker({Key key, this.initValue, this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new NumberPicker.integer(
        initialValue: initValue,
        minValue: 0,
        maxValue: 50,
        onChanged: onChanged);
  }
}
