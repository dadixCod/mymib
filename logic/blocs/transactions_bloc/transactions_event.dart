import 'package:mymib/data/models/transaction.dart';

abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {
  final String userId;

  LoadTransactions(this.userId);
}

class LoadFilteredTransactions extends TransactionEvent {
  final DateTime date;
  final String userId;
  LoadFilteredTransactions(this.date, this.userId);
}
class LoadFilteredRangeTransactions extends TransactionEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String userId;
  LoadFilteredRangeTransactions(this.startDate,this.endDate, this.userId);
}

class AddTransaction extends TransactionEvent {
  final String userId;
  final Transaction transaction;

  AddTransaction(this.userId, this.transaction);
}

class UpdateTransaction extends TransactionEvent {
  final String userId;
  final String transactionId;
  final Transaction transaction;

  UpdateTransaction(this.userId, this.transactionId, this.transaction);
}

class DeleteTransaction extends TransactionEvent {
  final String userId;
  final String transactionId;

  DeleteTransaction(this.userId, this.transactionId);
}
