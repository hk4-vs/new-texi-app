import 'package:flutter/material.dart';
import 'package:new_texi_app/models/book_ride_model.dart';
import 'package:new_texi_app/utils/utils.dart';

class AfterBookRideView extends StatefulWidget {
  const AfterBookRideView({super.key, required this.bookRideModel});
  final BookRideModel bookRideModel;

  @override
  State<AfterBookRideView> createState() => _AfterBookRideViewState();
}

class _AfterBookRideViewState extends State<AfterBookRideView> {
  int vehicleCharge = Utils.randomNumber();
  int platFormFee = 4;
  int random = Utils.randomNumber();
  int tax = 10;

  @override
  Widget build(BuildContext context) {
    int subTotal = int.parse(widget.bookRideModel.totalFare.toString());
    int total = tax + subTotal + platFormFee;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all()),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Vehicle Name :",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(child: Container()),
                      Text(
                        "${widget.bookRideModel.vehicleName}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Vehicle Type :",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(child: Container()),
                      Text(
                        "${widget.bookRideModel.vehicleType}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Vehicle Charge :",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(child: Container()),
                      Text(
                        "$vehicleCharge",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Platform Fee :",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(child: Container()),
                      Text(
                        "$platFormFee",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Tax :",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(child: Container()),
                      Text(
                        "$tax",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Sub Total :",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(child: Container()),
                      Text(
                        "${widget.bookRideModel.totalFare}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total :",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Expanded(child: Container()),
                      Text(
                        "$total",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
