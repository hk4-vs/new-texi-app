class BookRideModel {
  String? id;
  String? acceptedTime;
  String? latitude;
  String? longitude;
  String? driverId;
  String? pickLongitude;
  String? pickLatitude;
  String? dropLongitude;
  String? dropLatitude;
  String? acceptedLatitude;
  String? acceptedLongitude;
  String? bookingStatus;
  String? totalFare;
  String? tax;
  String? platFormFee;

  String? driver;

  String? userId;

  String? vehicleType;
  String? vehicleName;
  String? vehiclePerKeliometerPrice;
  String? pickLocation;
  String? dropLocation;
  String? pickTime;
  String? dropTime;
  String? date;
  BookRideModel(
      {this.date,
      this.dropLocation,
      this.vehicleName,
      this.dropTime,
      this.driver,
      this.id,
      this.pickLocation,
      this.pickTime,
      this.userId,
      this.vehicleType,
      this.totalFare,
      this.tax,
      this.platFormFee,
      this.driverId,
      this.acceptedTime,
      this.latitude,
      this.longitude,
      this.acceptedLatitude,
      this.acceptedLongitude,
      this.pickLatitude,
      this.pickLongitude,
      this.dropLatitude,
      this.dropLongitude,
      this.bookingStatus, this.vehiclePerKeliometerPrice});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "driver": driver,
      "userId": userId,
      "vehicleType": vehicleType,
      "pick": pickLocation,
      "drop": dropLocation,
      "pickTime": pickTime,
      "dropTime": dropTime,
      "date": date,
      "totalFare": totalFare,
      "tax": tax,
      "platFormFee": platFormFee,
      "driverId": driverId,
      "acceptedTime": acceptedTime,
      "latitude": latitude,
      "longitude": longitude,
      "acceptedLatitude": acceptedLatitude,
      "acceptedLongitude": acceptedLongitude,
      "pickLatitude": pickLatitude,
      "pickLongitude": pickLongitude,
      "dropLatitude": dropLatitude,
      "dropLongitude": dropLongitude,
      "bookingStatus": bookingStatus,
      "vehicleName": vehicleName,
      "vehiclePerKeliometerPrice": vehiclePerKeliometerPrice
    };
  }

  BookRideModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    driver = map["driver"];
    userId = map["userId"];

    vehicleType = map["vehicleType"];
    pickLocation = map["pick"];
    dropLocation = map["drop"];
    pickTime = map["pickTime"];
    dropTime = map["dropTime"];
    date = map["date"];
    totalFare = map["totalFare"];
    tax = map["tax"];
    platFormFee = map["platFormFee"];
    driverId = map["driverId"];
    acceptedTime = map["acceptedTime"];
    latitude = map["latitude"];
    longitude = map["longitude"];
    acceptedLatitude = map["acceptedLatitude"];
    acceptedLongitude = map["acceptedLongitude"];
    pickLatitude = map["pickLatitude"];
    pickLongitude = map["pickLongitude"];
    dropLatitude = map["dropLatitude"];
    dropLongitude = map["dropLongitude"];
    bookingStatus = map["bookingStatus"];
    vehicleName = map["vehicleName"];
    vehiclePerKeliometerPrice = map["vehiclePerKeliometerPrice"];
  }
}
