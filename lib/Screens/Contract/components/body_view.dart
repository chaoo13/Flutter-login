import 'package:building/Screens/Contract/components/background.dart';
import 'package:building/components/loading.dart';
import 'package:building/constants.dart';
import 'package:building/model/contract.dart';
import 'package:building/model/room.dart';
import 'package:building/model/user.dart';
import 'package:building/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ContractResultScreen extends StatefulWidget {
  final MyUser user;
  final Building building;
  final Room room;
  final int cid;
  final bool toModify;

  const ContractResultScreen(
      {Key key, this.user, this.building, this.cid, this.toModify, this.room})
      : super(key: key);

  @override
  _ContractResultScreenState createState() => _ContractResultScreenState();
}

class _ContractResultScreenState extends State<ContractResultScreen> {
  void saveModification() {}
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: widget.toModify ? Text('입실 내용 변경') : Text('입실 등록 완료'),
          ),
          actions: <Widget>[
            widget.toModify
                ? FlatButton(
                    textColor: Colors.white,
                    child: Text(
                      "저장",
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      // Navigator.of(context).pop();
                      saveModification();
                    })
                : FlatButton(
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
        body: FutureBuilder<Contract>(
            future: FirebaseService().getContract(widget.user.uid,
                widget.building.bid.toString(), widget.cid.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                    width: size.width,
                    height: size.height,
                    child: Center(
                        child: Text('Error' + snapshot.error.toString())));
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                Contract contract = snapshot.data;
                // return Text(p.name);
                return Background(
                    child: Container(
                        width: size.width,
                        height: size.height,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment(0.0, 0.0),
                                  height: 45,
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
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
                                          "방번호",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Center(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 40),
                                            child: Text(
                                              widget.room.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
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
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
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
                                          "입실자",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                          child: Center(
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 40),
                                                  child: Text(
                                                    contract.personName,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ))))
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(0.0, 0.0),
                                  height: 45,
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
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
                                          margin: EdgeInsets.only(left: 20),
                                          child: Text(
                                            contract.personPhoneNumber,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
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
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
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
                                          "최초 입실일",
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
                                                .format(contract.rentStartDate),
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
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
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
                                          "월세 납부일",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Text(
                                        '매월',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                          width: 40,
                                          margin: EdgeInsets.only(left: 20),
                                          child: TextFormField(
                                            readOnly: !widget.toModify,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "납부일";
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2)
                                            ],
                                            controller:
                                                contract.rentalPayDate != null
                                                    ? TextEditingController(
                                                        text: contract
                                                            .rentalPayDate
                                                            .toString())
                                                    : null,
                                            onChanged: (value) =>
                                                contract.rentalPayDate =
                                                    int.parse(value),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "일자",
                                                errorStyle:
                                                    TextStyle(height: -1)),
                                          )),
                                      Text('일'),
                                      Spacer(
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(0.0, 0.0),
                                  height: 45,
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
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
                                          "보증금",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: TextFormField(
                                                readOnly: !widget.toModify,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "보증금";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: contract.deposit !=
                                                        null
                                                    ? TextEditingController(
                                                        text: contract.deposit
                                                            .toString())
                                                    : null,
                                                onChanged: (value) => contract
                                                    .deposit = int.parse(value),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "보증금을 입력해주세요",
                                                    errorStyle:
                                                        TextStyle(height: -1)),
                                              ))),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(0.0, 0.0),
                                  height: 45,
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
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
                                          "월세",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: TextFormField(
                                                readOnly: !widget.toModify,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "월세";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    contract.monthlyRental !=
                                                            null
                                                        ? TextEditingController(
                                                            text: contract
                                                                .monthlyRental
                                                                .toString())
                                                        : null,
                                                onChanged: (value) =>
                                                    contract.monthlyRental =
                                                        int.parse(value),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "월세금을 입력해주세요",
                                                    errorStyle:
                                                        TextStyle(height: -1)),
                                              ))),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(0.0, 0.0),
                                  height: 100,
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          width: 1, color: Colors.black12)),
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: TextField(
                                    controller: TextEditingController(
                                        text: contract.memo),
                                    readOnly: !widget.toModify,
                                    maxLines: 4,
                                    onChanged: (value) => contract.memo = value,
                                    decoration: InputDecoration(
                                      hintText: "기타 메모",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                widget.toModify
                                    ? Container(
                                        alignment: Alignment(0.0, 0.0),
                                        margin: EdgeInsets.only(
                                            left: 30, right: 30, top: 10),
                                        child: FlatButton(
                                          color: kPrimaryColor,
                                          height: 45,
                                          minWidth: size.width,
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              if (contract.rentalPayDate ==
                                                      null ||
                                                  contract.rentalPayDate < 0 ||
                                                  contract.rentalPayDate > 31) {
                                                final snackBar = SnackBar(
                                                    content:
                                                        Text('월세 납무일을 확인해주세요'));
                                                Scaffold.of(context)
                                                    .showSnackBar(snackBar);
                                              } else if (contract.deposit ==
                                                      null ||
                                                  contract.deposit < 0) {
                                                final snackBar = SnackBar(
                                                    content:
                                                        Text('보증금을 확인해주세요'));
                                                Scaffold.of(context)
                                                    .showSnackBar(snackBar);
                                              } else if (contract
                                                          .monthlyRental ==
                                                      null ||
                                                  contract.monthlyRental < 0) {
                                                final snackBar = SnackBar(
                                                    content:
                                                        Text('월세 금액을 확인해주세요'));
                                                Scaffold.of(context)
                                                    .showSnackBar(snackBar);
                                              } else {
                                                Contract newContract =
                                                    new Contract(
                                                        cid: contract.cid,
                                                        roomId: widget.room.rid,
                                                        personId:
                                                            contract.personId,
                                                        // below changable values
                                                        monthlyRental: contract
                                                            .monthlyRental,
                                                        rentStartDate: contract
                                                            .rentStartDate,
                                                        deposit:
                                                            contract.deposit,
                                                        rentalPayDate: contract
                                                            .rentalPayDate,
                                                        memo: contract.memo);
                                                FirebaseService()
                                                    .updateContractData(
                                                        widget.user.uid,
                                                        widget.building.bid
                                                            .toString(),
                                                        newContract);
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ContractResultScreen(
                                                        user: widget.user,
                                                        building:
                                                            widget.building,
                                                        cid: contract.cid,
                                                        toModify: false,
                                                      );
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
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: kPrimaryColor)),
                                        ))
                                    : SizedBox(
                                        height: 1,
                                      ),
                                SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        )));
              }

              if (snapshot.connectionState != ConnectionState.done) {
                return Background(
                  child: Loading(),
                );
              }
            }));
  }
}
