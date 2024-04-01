class VehiclesModel {
  String? vehicleName;
  String? driver;
  String? type;
  String? vehiclePerKeliometerPrice;
  String? image;
  String? id;
  VehiclesModel({this.driver, this.type, this.id, this.image, this.vehicleName, this.vehiclePerKeliometerPrice});

  Map<String, dynamic> toMap() {
    return {
      "driver": driver,
      "type": type,
      "id":id,
      "image": image,
      "vehicleName": vehicleName,
      "vehiclePerKeliometerPrice": vehiclePerKeliometerPrice
    };
  }

  VehiclesModel.fromMap(Map<String, dynamic> map) {
    driver = map["driver"];
    type = map["type"];
    id = map["id"];
    image = map["image"];
    vehicleName = map["vehicleName"];
    vehiclePerKeliometerPrice = map["vehiclePerKeliometerPrice"];
  }
}