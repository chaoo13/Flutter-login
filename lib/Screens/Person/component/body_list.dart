import 'package:building/Screens/Home/components/background.dart';
import 'package:building/model/person.dart';
import 'package:building/model/user.dart';
import 'package:building/services/firestore_database.dart';
import 'package:flutter/material.dart';

class SelectGuestScreen extends StatefulWidget {
  final MyUser user;
  final Function setGuestInfo;

  const SelectGuestScreen({Key key, this.user, this.setGuestInfo})
      : super(key: key);

  @override
  _SelectGuestScreenState createState() => _SelectGuestScreenState();
}

class _SelectGuestScreenState extends State<SelectGuestScreen> {
  List<Person> _guests;
  List<Person> _showGuests;

  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    refreshGuests();
    _editingController.addListener(_searchList);
  }

  void _searchList() {
    if (_guests != null && _guests.isNotEmpty) {
      String keyword = _editingController.text;

      _showGuests = _guests.where((element) {
        if (element.name.toUpperCase().contains(keyword.toUpperCase())) {
          return true;
        } else if (element.phoneNumber != null &&
            element.phoneNumber.isNotEmpty) {
          if (element.phoneNumber.contains(keyword)) {
            return true;
          }
        }
        return false;
      }).toList();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void _setInitGuests() {
    _editingController.clear();
    setState(() {
      _showGuests = _guests;
    });
  }

  Future<void> refreshGuests() async {
    List<Person> guests =
        await FirebaseService().getGuestListOnce(widget.user.uid);

    setState(() {
      _guests = guests;
      _showGuests = guests;
    });
  }

  _showMaterialDialog(BuildContext context, Person person) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("알 림"),
              content:
                  new Text("${person.name}(${person.phoneNumber})을 선택하시겠습니까?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    widget.setGuestInfo(person);
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text('고객 선택하기'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: Background(
            child: Container(
          width: size.width,
          height: size.height,
          child: StreamBuilder<List<Person>>(
              stream: null,
              builder: (context, snapshot) {
                return Column(
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              autofocus: false,
                              controller: _editingController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: _setInitGuests,
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: _showGuests != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: _showGuests?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                Person c = _showGuests?.elementAt(index);
                                return ListTile(
                                  onTap: () {
                                    _showMaterialDialog(context, c);
                                  },
                                  // leading:
                                  //     CircleAvatar(child: Text(c.initials())),
                                  title: Text(c.name),
                                  subtitle: Text(c.phoneNumber),
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ],
                );
              }),
        )));
  }
}
