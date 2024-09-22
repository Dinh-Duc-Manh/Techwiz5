import 'dart:io';
import 'package:flutter/material.dart';

import '../../../model/Tours.dart';
import '../../../service/data.dart';
import '../../../service/tour_service.dart';
import 'add_tour_form_screen.dart';
import 'detail_tour_screen.dart';
import 'edit_tour_form_screen.dart';

class TourScreen extends StatefulWidget {
  @override
  _TourScreenState createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  List<Tours> tours = [];
  late TourService service;

  Future<void> getTours() async {
    try {
      service = TourService(await getDatabase());
      var data = await service.getAll();
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
    getTours();
  }

  void _navigateToAddTour() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTourFormScreen()),
    ).then((_) {
      getTours();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour Listing Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddTour,
            tooltip: 'Add New Tour',
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final tour = tours[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Container(
                width: 80,
                height: 80,
                child: _buildTourImage(tour.image),
              ),
              title: Text(
                tour.tour_name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: ${tour.tour_price.toStringAsFixed(2)} USD'),
                  Text('Time: ${tour.time}'),
                  Text('Nation: ${tour.nation}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditTourFormScreen(tour.tour_id),
                        ),
                      ).then((_) {
                        getTours();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showConfirm(context, tour.tour_id);
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailTourScreen(tour.tour_id),
                  ),
                );
              },
            ),
          );
        },
        itemCount: tours.length,
      ),
    );
  }

  Widget _buildTourImage(String imagePath) {
    if (imagePath.startsWith('/data/')) {
      // If it's an asset image
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);
        },
      );
    } else {
      return Image.asset(
        "assets/images/tours/$imagePath",
        fit: BoxFit.cover,
      );
    }
  }

  void showConfirm(BuildContext context, int tourId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete tour?'),
          content: Text('Are you sure you want to delete this tour???'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await service.delete(tourId);
                await getTours(); // Refresh the list after deletion
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
