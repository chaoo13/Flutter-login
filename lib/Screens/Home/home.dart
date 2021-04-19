import 'package:building/model/user.dart';
import 'package:building/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  MyUser user;
  Home(user) {
    this.user = user;
  }
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
