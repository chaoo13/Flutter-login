import 'package:building/Screens/Home/components/background.dart';
import 'package:building/Screens/Home/components/body.dart';
import 'package:building/model/user.dart';
import 'package:building/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:building/constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Home extends StatelessWidget {
  MyUser user;
  Home(user) {
    this.user = user;
  }
  final AuthService _auth = AuthService();
  bool _dialVisible = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Building'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () {
              _auth.signOut();
            },
          )
        ],
      ),
      body: HomeBody(),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 30,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: _dialVisible,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        // backgroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.person_add),
              backgroundColor: Colors.red,
              label: '회원 추가',
              labelStyle: TextStyle(fontSize: 15.0),
              onTap: () {
                print('FIRST CHILD');
              }),
          SpeedDialChild(
            child: Icon(Icons.add_business_outlined),
            backgroundColor: Colors.blue,
            label: '건물 추가',
            labelStyle: TextStyle(fontSize: 15.0),
            onTap: () {
              print('SECOND CHILD');
            },
          ),
        ],
      ),
    );
  }
}
