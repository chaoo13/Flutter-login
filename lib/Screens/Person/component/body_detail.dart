import 'package:building/Screens/Home/components/background.dart';
import 'package:building/Screens/Person/component/body_result.dart';
import 'package:building/constants.dart';
import 'package:building/model/person.dart';
import 'package:building/model/user.dart';
import 'package:building/services/encrpyt.dart';
import 'package:building/services/firestore_database.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:kopo/kopo.dart';

class PersonDetail extends StatefulWidget {
  final Contact contact;
  final MyUser user;

  const PersonDetail({Key key, this.contact, this.user}) : super(key: key);

  @override
  _PersonDetailState createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  final _formKey = GlobalKey<FormState>();
  final _relationList = ['관계', '가족', '친구', '동료', '기타'];
  String _selectedRelation = '관계';
  final _genderList = ['성별', '남성', '여성'];
  String _selectedGender = '성별';
  final _jobList = ['직업', '직장인', '학생', '주부', '기타'];
  String _selectedJob = '직업';
  String name;
  String phoneNumber;
  DateTime birthday;
  String relationName;
  String relationPhoneNumber;
  String memo;
  String jobName;
  String socNumber;
  String addressJSON;
  String postcode;
  String addressMain;
  String addressDetail;

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      name = widget.contact.displayName;
      if (widget.contact.phones != null && widget.contact.phones.isNotEmpty) {
        phoneNumber = widget.contact.phones.first.value;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SecureManager _secureManager = SecureManager(widget.user.uid);
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 10, 30, 0),
                  child: Text(
                    '고객 정보',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: size.width / 1.75,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              child: Text(
                                "이름",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Flexible(
                                child: Container(
                                    child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '이름';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) => name = value,
                              // readOnly: true,
                              controller: name != null
                                  ? TextEditingController(text: name)
                                  : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "이름 입력하세요",
                                  errorStyle: TextStyle(height: 0)),
                            ))),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        width: size.width / 4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Center(
                          child: DropdownButton(
                            value: _selectedGender,
                            items: _genderList
                                .map((value) => DropdownMenuItem(
                                    value: value, child: Text(value)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black12)),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          "전화번호",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Flexible(
                          child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "전화번호";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: phoneNumber != null
                                    ? TextEditingController(text: phoneNumber)
                                    : null,
                                onChanged: (value) => phoneNumber = value,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "전화번호를 입력하세요",
                                    errorStyle: TextStyle(height: -1)),
                              ))),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: size.width / 4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Center(
                          child: DropdownButton(
                            value: _selectedJob,
                            items: _jobList
                                .map((value) => DropdownMenuItem(
                                    value: value, child: Text(value)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedJob = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        width: size.width / 1.75,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: null,
                            onChanged: (value) => jobName = value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "소속명",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black12)),
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          "생년월일",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Flexible(
                          child: Container(
                              // margin: EdgeInsets.only(right: 20),
                              child: birthday == null
                                  ? FlatButton(
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            maxTime: DateTime.now(),
                                            minTime: DateTime(1930, 1, 1),
                                            onConfirm: (date) {
                                          print('confirm $date');
                                          setState(() {
                                            birthday = date;
                                          });
                                        },
                                            currentTime: DateTime(1980, 6, 15),
                                            locale: LocaleType.ko);
                                      },
                                      child: Text(
                                        '생년월일 선택하기',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ))
                                  : Row(
                                      children: [
                                        Spacer(
                                          flex: 3,
                                        ),
                                        Text(
                                          DateFormat('yyyy년 MM월 dd일')
                                              .format(birthday),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Spacer(
                                          flex: 5,
                                        ),
                                        Container(
                                            width: 50,
                                            child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    birthday = null;
                                                  });
                                                },
                                                child: Icon(Icons.clear)))
                                      ],
                                    ))),
                    ],
                  ),
                ),
                birthday != null
                    ? Container(
                        alignment: Alignment(0.0, 0.0),
                        height: 45,
                        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: Text(
                                "주민번호",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat('yyyyMMdd - ')
                                  .format(birthday)
                                  .substring(2),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Flexible(
                                child: Container(
                              width: size.width - 160,
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                maxLength: 7,
                                controller: null,
                                onChanged: (value) => socNumber = value,
                                decoration: InputDecoration(
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    border: InputBorder.none,
                                    hintText:
                                        '\u{2B24}\u{2B24}\u{2B24}\u{2B24}\u{2B24}\u{2B24}\u{2B24}',
                                    counterText: ""),
                              ),
                            )),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      ),
                Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black12)),
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          "주소입력",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Flexible(
                          child: Container(
                              // margin: EdgeInsets.only(right: 20),
                              child: postcode == null
                                  ? FlatButton(
                                      onPressed: () async {
                                        KopoModel model = await Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => Kopo(),
                                            ));
                                        print(model.toJson());
                                        setState(() {
                                          addressJSON =
                                              '${model.address} ${model.buildingName}${model.apartment == 'Y' ? '아파트' : ''} ${model.zonecode} ';
                                          postcode = model.zonecode;
                                          addressMain = model.address;
                                        });
                                      },
                                      child: Text(
                                        '우편번호 선택하기',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Spacer(
                                          flex: 5,
                                        ),
                                        Text(
                                          postcode,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Spacer(
                                          flex: 5,
                                        ),
                                        Container(
                                            width: 50,
                                            child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    postcode = null;
                                                    addressMain = null;
                                                  });
                                                },
                                                child: Icon(Icons.clear)))
                                      ],
                                    ))),
                    ],
                  ),
                ),

                addressMain != null
                    ? Container(
                        alignment: Alignment(0.0, 0.0),
                        height: 45,
                        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        padding: EdgeInsets.only(left: 30, right: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 90,
                              child: Text(
                                "주소",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Flexible(
                                child: Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(
                                      addressMain,
                                    ))),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      ),
                addressMain != null
                    ? Container(
                        alignment: Alignment(0.0, 0.0),
                        height: 45,
                        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 90,
                              child: Text(
                                "상세주소",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Flexible(
                                child: Container(
                                    // margin: EdgeInsets.only(right: 20),
                                    child: TextField(
                              controller: null,
                              onChanged: (value) => addressDetail = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "상세주소를 입력하세요",
                              ),
                            ))),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 10, 30, 0),
                  child: Text(
                    '비상연락처',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: size.width / 1.75,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              child: Text(
                                "이름",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Flexible(
                                child: Container(
                                    child: TextField(
                              controller: null,
                              onChanged: (value) => relationName = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "이름 입력하세요",
                              ),
                            ))),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        width: size.width / 4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Center(
                          child: DropdownButton(
                            value: _selectedRelation,
                            items: _relationList
                                .map((value) => DropdownMenuItem(
                                    value: value, child: Text(value)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedRelation = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black12)),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          "전화번호",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Flexible(
                          child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                controller: null,
                                onChanged: (value) =>
                                    relationPhoneNumber = value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "전화번호를 입력하세요",
                                ),
                              ))),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 10, 30, 0),
                  child: Text(
                    '메모',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 100,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black12)),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    maxLines: 4,
                    onChanged: (value) => memo = value,
                    decoration: InputDecoration(
                      hintText: "기타 메모",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                      alignment: Alignment(0.0, 0.0),
                      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: FlatButton(
                        color: kPrimaryColor,
                        height: 45,
                        minWidth: size.width,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print("name: ${name}");
                            // print(_secureManager.encypt(socNumber));
                            // print(_secureManager
                            //     .decypt(_secureManager.encypt(socNumber)));
                            if (birthday == null) {
                              final snackBar =
                                  SnackBar(content: Text('생일을 입력해주세요.'));
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else if (socNumber == null) {
                              final snackBar =
                                  SnackBar(content: Text('주민번호를 입력해주세요.'));
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else {
                              Person p = new Person(
                                  pid: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  name: name,
                                  phoneNumber: phoneNumber,
                                  postcode: postcode,
                                  birthday: birthday,
                                  encSocialNumber:
                                      _secureManager.encypt(socNumber),
                                  addressMain: addressMain ?? "",
                                  addressDetail: addressDetail ?? "",
                                  gender: _selectedGender,
                                  job: _selectedJob,
                                  jobName: jobName ?? "",
                                  relateName: relationName ?? "",
                                  relateRelation: _selectedRelation,
                                  relatePhoneNumber: relationPhoneNumber,
                                  memo: memo);
                              FirebaseService()
                                  .updateGuestData(widget.user.uid, p);
                              print("pid: " + p.pid);
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddPersonResultScreen(
                                        user: widget.user, pid: p.pid);
                                  },
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          '저장하기',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: kPrimaryColor)),
                      )),
                ),
                SizedBox(
                  height: 50,
                )
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                //   child: TextField(
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(), hintText: '전화번호'),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                //   child: TextField(
                //     decoration:
                //         InputDecoration(border: OutlineInputBorder(), hintText: '주소'),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
