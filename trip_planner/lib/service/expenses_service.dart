import 'package:sqflite/sqflite.dart';
import 'package:trip_planner/service/data.dart';
import '../model/Expenses.dart';

class ExpenseService {
  final Database db;

  ExpenseService(this.db);

  // Insert a new expense
  Future<void> insertExpense(Expenses expense) async {
    final db = await getDatabase();
    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }





}
