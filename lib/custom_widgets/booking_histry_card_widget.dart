import 'package:flutter/material.dart';
import 'package:new_texi_app/models/book_ride_model.dart';

import '../utils/utils.dart';
import '../view-models/chat_view_model.dart';

class BookingHistryCardView extends StatelessWidget {
  const BookingHistryCardView({super.key, required this.bookingHistry});
  final BookRideModel bookingHistry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), border: Border.all()),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Pick Location :",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(child: Container()),
              Text(
                "${bookingHistry.pickLocation}",
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
                "Drop Location :",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(child: Container()),
              Text(
                "${bookingHistry.dropLocation}",
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
                "Booking Date :",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(child: Container()),
              Text(
                Utils.formateDate(bookingHistry.date.toString()),
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
                "Booking Time :",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(child: Container()),
              Text(
                Utils.formateTime(bookingHistry.date.toString()),
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
                "Status :",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(child: Container()),
              Text(
                "${bookingHistry.bookingStatus}",
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
                "${bookingHistry.totalFare}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                ChatViewModel().checkChatRoomisExist(
                    userId: bookingHistry.userId.toString(),
                    driverId: bookingHistry.driverId.toString(),
                    context: context, bookingId: bookingHistry.id.toString());
              },
              child: Text(
                "Chat With Driver",
                style: Theme.of(context).textTheme.bodyLarge,
              ))
        ],
      ),
    );
  }
}
