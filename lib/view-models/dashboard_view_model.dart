import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:new_texi_app/models/book_ride_model.dart';
import 'package:new_texi_app/models/vhicles_model.dart';
import 'package:new_texi_app/utils/routes/route_names.dart';
import 'package:new_texi_app/utils/utils.dart';

import '../models/my_variables.dart';

class DashboardViewMode with ChangeNotifier {
  getVehicles() {
    MyVariables.firestore.collection('vehicles').get().then((value) {
      List<VehiclesModel> vehicles = value.docs
          .map((element) => VehiclesModel.fromMap(element.data()))
          .toList();
      _vehiclesList = vehicles;
      notifyListeners();
    });
  }

  List<VehiclesModel> _vehiclesList = [];
  List<VehiclesModel> get vehiclesList => _vehiclesList;

  VehiclesModel _selectedVehicle = VehiclesModel();
  VehiclesModel get selectedVehicle => _selectedVehicle;

  setSelectedVehicle(VehiclesModel vehicle) {
    _selectedVehicle = vehicle;
    log("Selected Vehicle : ${_selectedVehicle.toMap()}");
    notifyListeners();
  }

  bookRide(
      {required BookRideModel bookRideModel,
      required BuildContext context}) async {
    await MyVariables.firestore
        .collection('bookings')
        .doc(bookRideModel.id)
        .set(bookRideModel.toMap())
        .then((value) {
      Utils.toastMessage("Ride Booked Successfully");
      Navigator.pushNamed(context, RouteNames.afterBookRideView,
          arguments: {"bookRideModel": bookRideModel});
    });
  }
}
