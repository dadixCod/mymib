import 'package:mymib/data/models/transaction.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<Transaction> transactions;
  TransactionsLoaded(this.transactions);
}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {}

class NoTransactionAvailable extends TransactionState {}

class TransactionFailure extends TransactionState {
  final String errorMessage;

  TransactionFailure(this.errorMessage);
}
