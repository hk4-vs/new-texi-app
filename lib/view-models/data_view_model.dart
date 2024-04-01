import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_texi_app/models/vhicles_model.dart';

class DataViewMode {
  static createVhicleData() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection("vehicles")
        .doc(id)
        .set(VehiclesModel(
          id: id,
          driver: "John Doe",
          type: "Bike",
          vehiclePerKeliometerPrice: "40",
          image: "",
          vehicleName: "Hond bike",
        ).toMap());
    log("vehicle created");
  }
}
