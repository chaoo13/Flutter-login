import 'package:building/Screens/Person/component/background.dart';
import 'package:building/components/loading.dart';
import 'package:building/model/person.dart';
import 'package:building/model/user.dart';
import 'package:building/services/encrpyt.dart';
import 'package:building/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPersonResultScreen extends StatelessWidget {
  final MyUser user;
  final String pid;

  const AddPersonResultScreen({Key key, this.user, this.pid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SecureManager _secureManager = SecureManager(user.uid);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('회원 추가 완료'),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text(
                "확인",
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: FutureBuilder<Person>(
            future: FirebaseService().getGuest(user.uid, pid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                    width: size.width,
                    height: size.height,
                    child: Center(
                        child: Text('Error' + snapshot.error.toString())));
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return Background(
                  child: Loading(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                Person p = snapshot.data;
                // return Text(p.name);
                return Background(
                  child: Container(
                      width: size.width,
                      height: size.height,
                      child: SingleChildScrollView(
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
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width / 1.75,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 1, color: Colors.black12)),
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
                                          readOnly: true,
                                          controller: TextEditingController(
                                              text: p.name),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 1, color: Colors.black12)),
                                    child: Center(
                                        child: Text(
                                      p.gender,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              height: 45,
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
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
                                            controller: TextEditingController(
                                                text: p.phoneNumber ?? ""),
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              height: 45,
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: size.width / 4,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 1, color: Colors.black12)),
                                    child: Center(
                                        child: Text(
                                      p.job,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    )),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Container(
                                    width: size.width / 1.75,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 1, color: Colors.black12)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextField(
                                        controller: TextEditingController(
                                            text: p.jobName ?? ""),
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
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
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
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
                                          child: Row(
                                    children: [
                                      Spacer(
                                        flex: 3,
                                      ),
                                      Text(
                                        DateFormat('yyyy년 MM월 dd일')
                                            .format(p.birthday),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Spacer(
                                        flex: 3,
                                      ),
                                    ],
                                  ))),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              height: 45,
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
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
                                        .format(p.birthday)
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
                                      readOnly: true,
                                      maxLength: 7,
                                      controller: TextEditingController(
                                          text:
                                              '\u{2B24}\u{2B24}\u{2B24}\u{2B24}\u{2B24}\u{2B24}\u{2B24}'),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: ""),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              height: 45,
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
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
                                          child: Row(
                                    children: [
                                      Spacer(
                                        flex: 5,
                                      ),
                                      Text(
                                        p.postcode ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Spacer(
                                        flex: 5,
                                      ),
                                    ],
                                  ))),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              height: 45,
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
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
                                            p.addressMain ?? "",
                                          ))),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              height: 45,
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
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
                                    controller: TextEditingController(
                                        text: p.addressDetail ?? ""),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ))),
                                ],
                              ),
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
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width / 1.75,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 1, color: Colors.black12)),
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
                                          readOnly: true,
                                          controller: TextEditingController(
                                              text: p.relateName ?? ""),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 1, color: Colors.black12)),
                                    child: Center(
                                        child: Text(
                                      p.relateRelation ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              height: 45,
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
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
                                            readOnly: true,
                                            controller: TextEditingController(
                                                text:
                                                    p.relatePhoneNumber ?? ""),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
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
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                readOnly: true,
                                maxLines: 4,
                                controller:
                                    TextEditingController(text: p.memo ?? ""),
                                decoration: InputDecoration(
                                  hintText: "기타 메모",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(child: Text('회원 등록이 정상적으로 되었습니다.')),
                            SizedBox(
                              height: 50,
                            )
                          ]))),
                );
              }
            }));
  }
}
