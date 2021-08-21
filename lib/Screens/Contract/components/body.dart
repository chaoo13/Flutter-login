import 'package:building/Screens/Contract/components/background.dart';
import 'package:building/Screens/Contract/components/body_view.dart';
import 'package:building/Screens/Person/component/body_list.dart';
import 'package:building/constants.dart';
import 'package:building/model/contract.dart';
import 'package:building/model/person.dart';
import 'package:building/model/room.dart';
import 'package:building/model/user.dart';
import 'package:building/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ContractBody extends StatefulWidget {
  final MyUser user;
  final Building building;
  final Room room;

  const ContractBody({Key key, this.user, this.room, this.building})
      : super(key: key);
  @override
  _ContractBodyState createState() => _ContractBodyState();
}

class _ContractBodyState extends State<ContractBody> {
  final _formKey = GlobalKey<FormState>();
  Person guest;
  DateTime rentStartDate;
  int deposit;
  int monthlyRental;
  int rentalPayDate;
  String memo;

  void setGuestInfo(Person guest) {
    setState(() {
      this.guest = guest;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                              "입실자",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Flexible(
                              child: Container(
                                  // margin: EdgeInsets.only(right: 20),
                                  child: guest == null
                                      ? FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return SelectGuestScreen(
                                                      user: widget.user,
                                                      setGuestInfo:
                                                          setGuestInfo);
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            '입실자 선택하기',
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
                                              guest.name,
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
                                                        guest = null;
                                                      });
                                                    },
                                                    child: Icon(Icons.clear)))
                                          ],
                                        ))),
                        ],
                      ),
                    ),
                    guest != null
                        ? Container(
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
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      guest.phoneNumber,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
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
                                  child: rentStartDate == null
                                      ? FlatButton(
                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                maxTime: DateTime(
                                                    DateTime.now().year + 3,
                                                    12,
                                                    31),
                                                minTime: DateTime(2001, 1, 1),
                                                onConfirm: (date) {
                                              print('confirm $date');
                                              setState(() {
                                                rentStartDate = date;
                                                rentalPayDate =
                                                    rentStartDate.day;
                                              });
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.ko);
                                          },
                                          child: Text(
                                            '날짜 선택하기',
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
                                                  .format(rentStartDate),
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
                                                        rentStartDate = null;
                                                      });
                                                    },
                                                    child: Icon(Icons.clear)))
                                          ],
                                        ))),
                        ],
                      ),
                    ),
                    rentStartDate != null
                        ? Container(
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
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "납부일";
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(2)
                                      ],
                                      controller: rentalPayDate != null
                                          ? TextEditingController(
                                              text: rentalPayDate.toString())
                                          : null,
                                      onChanged: (value) =>
                                          rentalPayDate = int.parse(value),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "일자",
                                          errorStyle: TextStyle(height: -1)),
                                    )),
                                Text('일'),
                                Spacer(
                                  flex: 1,
                                ),
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
                                  margin: EdgeInsets.only(right: 20),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "보증금";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: deposit != null
                                        ? TextEditingController(
                                            text: deposit.toString())
                                        : null,
                                    onChanged: (value) =>
                                        deposit = int.parse(value),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "보증금을 입력해주세요",
                                        errorStyle: TextStyle(height: -1)),
                                  ))),
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
                              "월세",
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
                                        return "월세";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: monthlyRental != null
                                        ? TextEditingController(
                                            text: monthlyRental.toString())
                                        : null,
                                    onChanged: (value) =>
                                        monthlyRental = int.parse(value),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "월세금을 입력해주세요",
                                        errorStyle: TextStyle(height: -1)),
                                  ))),
                        ],
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
                    Container(
                        alignment: Alignment(0.0, 0.0),
                        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: FlatButton(
                          color: kPrimaryColor,
                          height: 45,
                          minWidth: size.width,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (guest == null) {
                                final snackBar =
                                    SnackBar(content: Text('입실자를 선택해주세요'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else if (rentStartDate == null) {
                                final snackBar =
                                    SnackBar(content: Text('최초 입실일을 선택해주세요'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else if (rentalPayDate == null ||
                                  rentalPayDate < 0 ||
                                  rentalPayDate > 31) {
                                final snackBar =
                                    SnackBar(content: Text('월세 납무일을 확인해주세요'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else if (deposit == null || deposit < 0) {
                                final snackBar =
                                    SnackBar(content: Text('보증금을 확인해주세요'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else if (monthlyRental == null ||
                                  monthlyRental < 0) {
                                final snackBar =
                                    SnackBar(content: Text('월세 금액을 확인해주세요'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                Contract contract = new Contract(
                                    cid: DateTime.now().millisecondsSinceEpoch,
                                    roomId: widget.room.rid,
                                    personId: int.parse(guest.pid),
                                    personName: guest.name,
                                    personPhoneNumber: guest.phoneNumber,
                                    monthlyRental: monthlyRental,
                                    rentStartDate: rentStartDate,
                                    deposit: deposit,
                                    rentalPayDate: rentalPayDate,
                                    memo: memo);
                                FirebaseService().updateContractData(
                                    widget.user.uid,
                                    widget.building.bid.toString(),
                                    contract);
                                widget.room.contractId = contract.cid;
                                FirebaseService().occupyRoomData(
                                    widget.user.uid,
                                    widget.building.bid.toString(),
                                    widget.room);
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ContractResultScreen(
                                        user: widget.user,
                                        building: widget.building,
                                        cid: contract.cid,
                                        room: widget.room,
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
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: kPrimaryColor)),
                        )),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )));
  }
}
