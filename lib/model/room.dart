class Building {
  final int bid;
  final String name;
  List<Room> rooms;

  Building({this.bid, this.name, this.rooms});

  Map<String, dynamic> toMap() {
    return {
      'bid': bid,
      'name': name,
    };
  }
}

class Room {
  final int rid;
  int groupId;
  String name;
  int contractId;

  Room({this.rid, this.name, this.groupId, this.contractId});

  Map<String, dynamic> toMap() {
    return {
      'rid': rid,
      'groupId': groupId,
      'name': name,
      'contractId': contractId,
    };
  }
}

// class Rental {
//   int rid;
//   final int cid;
// }
