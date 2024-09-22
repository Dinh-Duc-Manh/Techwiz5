import 'package:flutter/material.dart';
import '../../../model/Trips.dart';
import '../../../service/data.dart';
import '../../../service/trip_service.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  List<Trips> trips = [];
  late TripService service;

  Future<void> getTrips() async {
    try {
      service = TripService(await getDatabase());
      var data = await service.getAll();
      setState(() {
        trips = data;
      });
    } catch (e) {
      print("Error getting trips: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getTrips();
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
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Container(
                width: 80,
                height: 80,
                child: _buildTripImage(trip), // Adjust this as needed
              ),
              title: Text(
                trip.trip_name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Giá: ${trip.budget.toStringAsFixed(2)} VND'),
                  Text('Thời gian: ${trip.start_date.toLocal()} - ${trip.end_date.toLocal()}'),
                  Text('Điểm đến: ${trip.destination}'),
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

  Widget _buildTripImage(Trips trip) {
    // Implement your image handling logic here
    return Placeholder(); // Placeholder for demonstration
  }
}
