import 'package:flutter/material.dart';
import 'package:new_texi_app/models/my_variables.dart';
import 'package:new_texi_app/utils/routes/route_names.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MyVariables.width(context) * 0.6,
      child: Column(
        children: [
          const DrawerHeader(
              child: CircleAvatar(
            child: Icon(Icons.person),
          )),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.bookingHistroyView,
                );
              },
              child: const Text("Booking History")),
        ],
      ),
    );
  }
}
