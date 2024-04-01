
class MessageModel {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  String? dateTime;
  String? messageType;
  String? messageStatus;
  String? chatRoomId;
  String? imageUrl;
  String? audioUrl;

  MessageModel(
      {this.id,
      this.chatRoomId,
      this.message,
      this.dateTime,
      this.messageType,
      this.messageStatus,
      this.receiverId,
      this.senderId,
      this.imageUrl,
      this.audioUrl});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "messageType": messageType,
      "messageStatus": messageStatus,
      "dateTime": dateTime,
      "chatRoomId": chatRoomId,
      "imageUrl": imageUrl,
      "audioUrl": audioUrl
    };
  }

  MessageModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    senderId = map["senderId"];
    receiverId = map["receiverId"];
    message = map["message"];
    messageType = map["messageType"];
    messageStatus = map["messageStatus"];
    dateTime = map["dateTime"];
    chatRoomId = map["chatRoomId"];
    imageUrl = map["imageUrl"];
    audioUrl = map["audioUrl"];
  }
}
