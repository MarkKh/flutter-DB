import 'package:db/models/transaction.dart';
import 'package:flutter/foundation.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [];

  List<Transaction> getTransaction() {
    return transactions;
  }

  void addTransaction(Transaction statement) {
    transactions.insert(0, statement);
    notifyListeners();
  }
}
