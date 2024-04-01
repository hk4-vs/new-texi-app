// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../models/user_model.dart';

// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key, required this.user});
//   final UserModel user;

//   @override
//   State<DashboardView> createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(21.256246, 81.590223),
//     zoom: 14,
//   );
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         myLocationButtonEnabled: true,
//         myLocationEnabled: true,
//         compassEnabled: true,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         // markers: Set<Marker>.of(_markers),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     // var checkPermission = await Geolocator.checkPermission();
//       //     // log("permission ${checkPermission.index}");
//       //     // UtilsClass.getCurrentLocation().then((value) async {
//       //     //   log("my current location is : ${value.latitude} lat , ${value.longitude} lon");

//       //     //   // Create a new marker
//       //     //   var newMarker = Marker(
//       //     //       markerId: const MarkerId("1"),
//       //     //       position: LatLng(value.latitude, value.longitude),
//       //     //       infoWindow: const InfoWindow(title: "My Location"));

//       //     //   // Add the new marker to the list of markers
//       //     //   _markers.add(newMarker);

//       //     //   CameraPosition cameraPosition = CameraPosition(
//       //     //       target: LatLng(value.latitude, value.longitude), zoom: 14);
//       //     //   final GoogleMapController controller = await _controller.future;
//       //     //   controller
//       //     //       .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//       //     //   setState(() {});
//       //     // });
//       //   },
//       //   child: const Icon(Icons.my_location),
//       // ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_texi_app/custom_widgets/my_drawer_widget.dart';
import 'package:new_texi_app/models/book_ride_model.dart';
import 'package:new_texi_app/models/my_variables.dart';
import 'package:new_texi_app/view-models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/my_text_field_widget.dart';
import '../../custom_widgets/show_vehicles_widget.dart';
import '../../models/user_model.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key, required this.user});
  final UserModel user;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  TextEditingController pickLocationController = TextEditingController();
  TextEditingController dropLocationController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Provider.of<DashboardViewMode>(context, listen: false).getVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      endDrawer: const MyDrawerWidget(),
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<DashboardViewMode>(
          builder: (context, provider, child) {
            log("id  ${provider.selectedVehicle.id}");
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(
                      height: 40,
                    ),
                    MyTextFieldWidget(
                        hintText: "Pick Location",
                        controller: pickLocationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Pick Location is required";
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFieldWidget(
                        hintText: "Drop Location",
                        controller: dropLocationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Drop Location is required";
                          }
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    ShowVehiclesWidget(
                      vehicles: provider.vehiclesList,
                      provider: provider,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    provider.selectedVehicle.id.toString() == "null"
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  int totalFare = int.parse(provider
                                      .selectedVehicle.vehiclePerKeliometerPrice
                                      .toString());
                                  String id = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  BookRideModel bookRideModel = BookRideModel(
                                      id: id,
                                      acceptedTime: "0",
                                      acceptedLatitude: "0",
                                      acceptedLongitude: "0",
                                      latitude: "0",
                                      longitude: "0",
                                      platFormFee: "0",
                                      totalFare: "${totalFare * 10}",
                                      tax: "0",
                                      bookingStatus: "0",
                                      driverId: "0",
                                      pickLatitude: "0",
                                      pickLongitude: "0",
                                      dropLatitude: "0",
                                      dropLongitude: "0",
                                      pickLocation:
                                          pickLocationController.text.trim(),
                                      dropLocation:
                                          dropLocationController.text.trim(),
                                      userId: widget.user.uid,
                                      date: DateTime.now().toString(),
                                      pickTime: "0",
                                      dropTime: "0",
                                      vehicleType:
                                          provider.selectedVehicle.type,
                                      driver: provider.selectedVehicle.driver,
                                      vehicleName:
                                          provider.selectedVehicle.vehicleName,
                                      vehiclePerKeliometerPrice: provider
                                          .selectedVehicle
                                          .vehiclePerKeliometerPrice);

                                  provider.bookRide(
                                      bookRideModel: bookRideModel,
                                      context: context);
                                  log("pick location: ${pickLocationController.text.trim()}");
                                  log("drop location: ${dropLocationController.text.trim()}");
                                  log("validate");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(MyVariables.width(context), 46)),
                              child: const Text("Go"),
                            ),
                          ),
                    const SizedBox(
                      height: 40,
                    ),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     DataViewMode.createVhicleData();
      //   },
      //   child: Text("Submit"),
      // )
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
