import 'package:building/Screens/Person/component/background.dart';
import 'package:building/Screens/Person/personDetail.dart';
import 'package:building/model/user.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class PersonBody extends StatefulWidget {
  final MyUser user;
  const PersonBody({Key key, this.user}) : super(key: key);
  @override
  _PersonBodyState createState() => _PersonBodyState();
}

class _PersonBodyState extends State<PersonBody> {
  List<Contact> _contacts;
  List<Contact> _showContacts;

  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshContacts();
    _editingController.addListener(_searchList);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void _searchList() {
    if (_contacts != null && _contacts.isNotEmpty) {
      String keyword = _editingController.text;

      _showContacts = _contacts.where((element) {
        if (element.displayName.toUpperCase().contains(keyword.toUpperCase())) {
          return true;
        } else if (element.phones != null && element.phones.isNotEmpty) {
          for (var phone in element.phones) {
            if (phone.value.contains(keyword)) {
              return true;
            }
          }
        }
        return false;
      }).toList();
      setState(() {});
    }
  }

  void _goPersonDetail(Contact c, MyUser user) {
    Navigator.of(context).pop();
    print("select person : ${c.displayName}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddPersonDetailScreen(contact: c, user: user);
        },
      ),
    );
  }

  void _setInitContacts() {
    _editingController.clear();
    setState(() {
      _showContacts = _contacts;
    });
  }

  Future<void> refreshContacts() async {
    // Load without thumbnails initially.
    var contacts = (await ContactsService.getContacts(
            withThumbnails: false, iOSLocalizedLabels: false))
        .toList();
//      var contacts = (await ContactsService.getContactsForPhone("8554964652"))
//          .toList();
    setState(() {
      _contacts = contacts;
      _showContacts = _contacts;
    });

    // Lazy load thumbnails after rendering initial contacts.
    // for (final contact in contacts) {
    //   ContactsService.getAvatar(contact).then((avatar) {
    //     if (avatar == null) return; // Don't redraw if no change.
    //     setState(() => contact.avatar = avatar);
    //   });
    // }
  }

  _showMaterialDialog(BuildContext context, Contact c) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("알 림"),
              content: new Text(
                  "${c.displayName ?? ""}(${c.phones.isEmpty ? "" : c.phones.first.value}) 을 선택하시겠습니까?"),
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
                    _goPersonDetail(c, widget.user);
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Container(
        width: size.width,
        height: size.height,
        child: Column(
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
                        onPressed: _setInitContacts,
                      )),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: _showContacts != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _showContacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        Contact c = _showContacts?.elementAt(index);
                        return ListTile(
                          onTap: () {
                            _showMaterialDialog(context, c);
                          },
                          leading: (c.avatar != null && c.avatar.length > 0)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(c.avatar))
                              : CircleAvatar(child: Text(c.initials())),
                          title: Text(c.displayName ?? ""),
                          subtitle: Text(
                              c.phones.isEmpty ? "" : c.phones.first.value),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
