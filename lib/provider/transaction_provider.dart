import 'package:flutter/material.dart';

import '../db_helper/transactions_db_helper.dart';
import '../model/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  bool isLoading = false;
  List<TransactionModel> _transaction = [];

  final TransactionsDatabaseHelper _databaseHelper =
      TransactionsDatabaseHelper();

  List<TransactionModel> get users => _transaction;

  Future<void> loadTransaction() async {
    isLoading = true;
    _transaction = await _databaseHelper.getActiveTransactions();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _databaseHelper.insertTransactions(transaction);
    notifyListeners();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await _databaseHelper.updateTransaction(transaction);
    notifyListeners();
  }

  /* Delete Transaction
  Future<void> deleteTransaction(int id) async {
    await _databaseHelper.deleteUser(id);
    await loadUsers();
  }
   */
}
