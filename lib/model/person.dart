import 'package:intl/intl.dart';

class Person {
  String pid;
  String name;
  String phoneNumber;
  String postcode;
  DateTime birthday;
  String encSocialNumber;
  String addressMain;
  String addressDetail;
  String gender;
  String job;
  String jobName;
  String relateName;
  String relateRelation;
  String relatePhoneNumber;
  String memo;

  Person(
      {this.pid,
      this.name,
      this.phoneNumber,
      this.postcode,
      this.birthday,
      this.encSocialNumber,
      this.addressMain,
      this.addressDetail,
      this.gender,
      this.job,
      this.jobName,
      this.relateName,
      this.relateRelation,
      this.relatePhoneNumber,
      this.memo});

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'name': name,
      'phoneNumber': phoneNumber,
      'postcode': postcode,
      'birthday': DateFormat('yyyyMMdd').format(birthday),
      'encSocialNumber': encSocialNumber,
      'addressMain': addressMain,
      'addressDetail': addressDetail,
      'gender': gender,
      'job': job,
      'jobName': jobName,
      'relateName': relateName,
      'relateRelation': relateRelation,
      'relatePhoneNumber': relatePhoneNumber,
      'memo': memo,
    };
  }

  factory Person.fromJson(Map<String, dynamic> data) => Person(
      pid: data['pid'].toString(),
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      postcode: data['postcode'],
      birthday: DateTime.parse(data['birthday']),
      encSocialNumber: data['encSocialNumber'],
      addressMain: data['addressMain'] ?? "",
      addressDetail: data['addressDetail'] ?? "",
      gender: data['gender'],
      job: data['job'],
      jobName: data['jobName'] ?? "",
      relateName: data['relationName'] ?? "",
      relateRelation: data['relateRelation'],
      relatePhoneNumber: data['relationPhoneNumber'],
      memo: data['memo']);
}
