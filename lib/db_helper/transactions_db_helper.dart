import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/transaction_model.dart';

class TransactionsDatabaseHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'transactions.db');

    return await openDatabase(path,
        version: 1, onCreate: _onCreateTransactions);
  }

  Future<void> _onCreateTransactions(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        transactionNumber TEXT,
        amount REAL,
        date TEXT,
        commission REAL,
        total REAL,
        operationType TEXT,
        status TEXT
      )
    ''');
  }

  Future<int> insertTransactions(TransactionModel transaction) async {
    Database? db = await database;
    return await db!.insert('transactions', transaction.toMap());
  }

  /* get transaction
  Future<List<TransactionModel>> getAllTransaction() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query('transactions');
    return List.generate(maps.length, (i) {
      return TransactionModel.fromMap(maps[i]);
    });
  }
   */

  Future<List<TransactionModel>> getActiveTransactions() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query(
      'transactions',
      where: 'status = ?', // Adjust the field name if needed
      whereArgs: ['active'], // Set the desired status to filter by
      orderBy: 'id DESC',
    );

    return List.generate(maps.length, (i) {
      return TransactionModel.fromMap(maps[i]);
    });
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    Database? db = await database;
    return await db!.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  /*
  Future<int> deleteTransaction(int id) async {
    Database? db = await database;
    return await db!.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
   */
}
