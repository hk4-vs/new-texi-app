class DriverUserModel {
  String? uid;
  String? name;
  String? email;
  String? profilePic;
  String? password;
  String? drivingLicenseImageUrl;
  String? vehicleImageUrl;
  String? vehicleDocumentImageUrl;
  


  DriverUserModel({this.uid, this.name, this.email, this.profilePic, this.password, this.drivingLicenseImageUrl, this.vehicleImageUrl, this.vehicleDocumentImageUrl});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "profilePic": profilePic,
      "password": password,
      "drivingLicenseImageUrl": drivingLicenseImageUrl,
      "vehicleImageUrl": vehicleImageUrl,
      "vehicleDocumentImageUrl": vehicleDocumentImageUrl
    };
  }

  DriverUserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    name = map["name"];
    email = map["email"];
    profilePic = map["profilePic"];
    password = map["password"];
    drivingLicenseImageUrl = map["drivingLicenseImageUrl"];
    vehicleImageUrl = map["vehicleImageUrl"];
    vehicleDocumentImageUrl = map["vehicleDocumentImageUrl"];
  }
}
