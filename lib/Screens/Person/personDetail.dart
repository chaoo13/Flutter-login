import 'package:building/Screens/Person/component/body_detail.dart';
import 'package:building/model/user.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddPersonDetailScreen extends StatelessWidget {
  final Contact contact;
  final MyUser user;

  const AddPersonDetailScreen({Key key, this.contact, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('고객 정보 입력'),
          actions: <Widget>[],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: PersonDetail(contact: contact, user: user),
    );
  }
}
