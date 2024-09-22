import 'dart:io';

import 'package:flutter/material.dart';
import '../../../model/Tours.dart';
import '../../../model/Trips.dart';
import '../../../service/data.dart';
import '../../../service/tour_service.dart';
import '../../../service/trip_service.dart';

class AdTripScreen extends StatefulWidget {
  const AdTripScreen({super.key});
  @override
  _AdTripScreenState createState() => _AdTripScreenState();
}

class _AdTripScreenState extends State<AdTripScreen> {
  List<Trips> trips = [];
  late TripService tripService;
  List<Tours> tours = [];
  late TourService tourService;

  Future<void> getTrips() async {
    try {
      tripService = TripService(await getDatabase());
      var data = await tripService.getAll();
      setState(() {
        trips = data;
      });
    } catch (e) {
      print("Error getting trips: $e");
    }
  }

  Future<void> getTours() async {
    try {
      tourService = TourService(await getDatabase());
      var data = await tourService.getAll();
      setState(() {
        tours = data;
      });
    } catch (e) {
      print("Error getting tours: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getTrips();
    getTours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Trip'),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          // Find the corresponding tour for this trip
          final tour = tours.firstWhere(
                (t) => t.tour_id == trip.tour_id,
          );
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Container(
                width: 80,
                height: 80,
                child: _buildTripImage(tour.image),
              ),
              title: Text(
                trip.trip_name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Giá: ${trip.budget.toStringAsFixed(2)} USD'),
                  Text('Thời gian: ${trip.start_date.toLocal()} - ${trip.end_date.toLocal()}'),
                  Text('Điểm đến: ${trip.destination}'),
                  Text('Mã chuyến đi: ${trip.trip_id}'),
                ],
              ),
              onTap: () {
                // You can navigate to a detail page if needed
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTripImage(String imagePath) {
    if (imagePath.startsWith('/data/')) {
      // If it's a file image
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);
        },
      );
    } else {
      // If it's an asset image
      return Image.asset(
        "assets/images/tours/$imagePath",
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.image_not_supported);
        },
      );
    }
  }
}