import 'package:sqflite/sqflite.dart';
import 'package:trip_planner/service/data.dart';
import '../model/Trips.dart';

class TripService {
  final Database db;

  TripService(this.db);

  // Insert a new trip
  Future<void> insertTrip(Trips trip) async {
    final db = await getDatabase();
    await db.insert(
      'trips',
      trip.toMap(), // Make sure to map only the necessary fields, not trip_id
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  // Fetch all trips

  Future<List<Trips>> getAll() async {
    final List<Map<String, dynamic>> maps = await db.query('trips');

    return List.generate(maps.length, (i) {
      return Trips(
        maps[i]['trip_id'],
        maps[i]['trip_name'],
        DateTime.parse(maps[i]['start_date']), // Parse back to DateTime
        DateTime.parse(maps[i]['end_date']),   // Parse back to DateTime
        maps[i]['destination'],
        maps[i]['total_price'],
        maps[i]['tour_id'],
        maps[i]['user_id'],
      );
    });
  }

}
