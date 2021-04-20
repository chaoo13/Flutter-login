class Building {
  int bid;
  final String name;
  List<Room> rooms;

  Building(this.name);
}

class Room {
  int rid;
  final int groupId;
  final String name;
  Contract contract;

  Room({this.name, this.groupId});

  Map<String, dynamic> toMap() {
    return {
      'rid': rid,
      'groupId': groupId,
      'name': name,
      'contract': contract,
    };
  }
}

class Contract {
  int cid;
  final int roomId;
  final int personId;
  final int monthlyRent;
  final String rentDate;
  final int deposit;
  final String depositDate;
  final String signDate;
  final String startDate;

  Contract(
      {this.roomId,
      this.personId,
      this.monthlyRent,
      this.rentDate,
      this.deposit,
      this.depositDate,
      this.signDate,
      this.startDate});
}

// class Rental {
//   int rid;
//   final int cid;
// }
