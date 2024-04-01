import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_texi_app/models/book_ride_model.dart';
import 'package:new_texi_app/models/my_variables.dart';
import 'package:new_texi_app/view-models/chat_view_model.dart';

import '../custom_widgets/booking_histry_card_widget.dart';
import '../custom_widgets/my_drawer_widget.dart';

class BookingHistroyView extends StatefulWidget {
  const BookingHistroyView({
    super.key,
  });

  @override
  State<BookingHistroyView> createState() => _BookingHistroyViewState();
}

class _BookingHistroyViewState extends State<BookingHistroyView> {
  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    log("histry uid: $uid");
    return Scaffold(
      endDrawer: const MyDrawerWidget(),
      appBar: AppBar(
        title: const Text("Booking History"),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: MyVariables.firestore
                .collection("bookings")
                .where("userId", isEqualTo: uid.toString())
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              List<BookRideModel> bookingHistryList = documents
                  .map(
                    (e) =>
                        BookRideModel.fromMap(e.data() as Map<String, dynamic>),
                  )
                  .toList();
              // when data is empty or not found
              if (bookingHistryList.isEmpty) {
                return const Center(
                  child: Text("No Booking History Found"),
                );
              }

              // When data is found
              return ListView.builder(
                  itemCount: bookingHistryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {

                        // userId and driverId extra for chatroom model
                        ChatViewModel().checkChatRoomisExist(
                            userId: bookingHistryList[index].userId.toString(),
                            driverId:
                                bookingHistryList[index].driverId.toString(),
                            context: context,
                            bookingId: bookingHistryList[index].id.toString());
                      },
                      child: BookingHistryCardView(
                        bookingHistry: bookingHistryList[index],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
