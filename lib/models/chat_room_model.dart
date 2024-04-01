class ChatRoomMode {
  String? id;
  String? driverId;
  String? userId;
  String? bookingId;

  ChatRoomMode({this.driverId, this.id, this.userId, this.bookingId});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "driverId": driverId,
      "userId": userId,
      "bookingId": bookingId
    };
  }

  ChatRoomMode.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    driverId = map["driverId"];
    userId = map["userId"];
    bookingId = map["bookingId"];
  }
}
