class Person {
  final int pid;
  final String name;
  final String phoneNumber;
  final String address;
  final String socialNumber;
  String jobName;
  String relateName;
  String relatePhoneNumber;
  String memo;

  Person(
      {this.pid, this.name, this.phoneNumber, this.address, this.socialNumber});

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'socialNumber': socialNumber,
      'jobName': jobName,
      'relateName': relateName,
      'relatePhoneNumber': relatePhoneNumber,
      'memo': memo,
    };
  }
}
