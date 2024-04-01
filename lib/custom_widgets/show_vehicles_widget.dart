import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/vhicles_model.dart';
import '../view-models/dashboard_view_model.dart';

class ShowVehiclesWidget extends StatelessWidget {
  const ShowVehiclesWidget(
      {super.key, required this.vehicles, required this.provider});
  final List<VehiclesModel> vehicles;
  final DashboardViewMode provider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          return provider.selectedVehicle == vehicles[index]
              ? ListTile(
                  onTap: () {
                    provider.setSelectedVehicle(vehicles[index]);
                  },
                  tileColor: Theme.of(context).colorScheme.primary,
                  leading: Icon(
                    CupertinoIcons.car_detailed,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  title: Text(
                    vehicles[index].vehicleName.toString(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  subtitle: Text(
                    vehicles[index].type.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  trailing: Text(
                    "\u20B9 ${vehicles[index].vehiclePerKeliometerPrice} /Km",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                )
              : ListTile(
                  onTap: () {
                    provider.setSelectedVehicle(vehicles[index]);
                  },
                  tileColor: Theme.of(context).colorScheme.onPrimary,
                  leading: const Icon(
                    CupertinoIcons.car_detailed,
                  ),
                  title: Text(
                    vehicles[index].vehicleName.toString(),
                    style: Theme.of(context).textTheme.titleMedium!,
                  ),
                  subtitle: Text(
                    vehicles[index].type.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  trailing: Text(
                    "\u20B9 ${vehicles[index].vehiclePerKeliometerPrice} /Km",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
        });
  }
}
