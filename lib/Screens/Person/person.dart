import 'package:building/Screens/Person/component/body.dart';
import 'package:building/Screens/Person/personDetail.dart';
import 'package:building/model/user.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PersonAdd extends StatefulWidget {
  final MyUser user;

  const PersonAdd({Key key, this.user}) : super(key: key);

  @override
  _PersonAddState createState() => _PersonAddState();
}

class _PersonAddState extends State<PersonAdd> {
  bool getPermission = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        getPermission = true;
      });
    } else {
      setState(() {
        getPermission = false;
      });

      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      Scaffold.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("getPermission : ${getPermission}");
    return Scaffold(
        appBar: AppBar(
            title: Text('주소록에서 추가'),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                child: Text(
                  "건너뛰기",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddPersonDetailScreen(user: widget.user);
                      },
                    ),
                  );
                  // Navigator.popAndPushNamed(context, '/addPersonDetail');
                },
              )
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: getPermission ? PersonBody(user: widget.user) : null);
  }
}
