import 'package:intl/intl.dart';

class Contract {
  final int cid;
  final int roomId;
  final int personId;
  int monthlyRental;
  final DateTime rentStartDate;
  final DateTime rentEndDate;
  int deposit;
  int rentalPayDate;
  String memo;
  final String personName;
  final String personPhoneNumber;

  Contract({
    this.memo,
    this.cid,
    this.rentEndDate,
    this.roomId,
    this.personId,
    this.monthlyRental,
    this.rentStartDate,
    this.deposit,
    this.rentalPayDate,
    this.personName,
    this.personPhoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'memo': this.memo ?? "",
      'cid': this.cid,
      'rentEndDate': this.rentEndDate ?? "",
      'roomId': this.roomId,
      'personId': this.personId,
      'monthlyRental': this.monthlyRental,
      'rentStartDate': DateFormat('yyyyMMdd').format(this.rentStartDate),
      'deposit': this.deposit,
      'rentalPayDate': this.rentalPayDate,
      'personName': this.personName,
      'personPhoneNumber': this.personPhoneNumber,
    };
  }

  factory Contract.fromJson(Map<String, dynamic> data) => Contract(
        memo: data['memo'],
        cid: data['cid'],
        rentEndDate: data['rentEndDate'] != ""
            ? DateTime.parse(data['rentEndDate'])
            : null,
        roomId: data['roomId'],
        personId: data['personId'],
        monthlyRental: data['monthlyRental'],
        rentStartDate: DateTime.parse(data['rentStartDate']),
        deposit: data['deposit'],
        rentalPayDate: data['rentalPayDate'],
        personName: data['personName'],
        personPhoneNumber: data['personPhoneNumber'],
      );
}
