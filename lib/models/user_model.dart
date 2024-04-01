class UserModel{
  String? uid;
  String? name;
  String? email;
  String? profilePic;
  String? password;

  UserModel({this.uid, this.name, this.email, this.profilePic, this.password});

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "profilePic": profilePic,
      "password": password
    };
  }

  UserModel.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    name = map["name"];
    email = map["email"];
    profilePic = map["profilePic"];
    password = map["password"];

  }
}