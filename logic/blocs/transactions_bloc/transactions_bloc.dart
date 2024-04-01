// ignore_for_file: unused_field, unnecessary_type_check

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymib/data/models/transaction.dart';
import 'package:mymib/logic/blocs/date_bloc.dart/bloc/date_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_event.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_state.dart';
import 'package:mymib/logic/services/transactions_service.dart';

class TransactionsBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionsService transactionsService = TransactionsService();
  final DateBloc dateBloc;
  StreamSubscription<DateState>? _dateSubscription;
  TransactionsBloc({required this.dateBloc}) : super(TransactionsLoaded([])) {
    _dateSubscription = dateBloc.date.listen((dateState) {
      if (dateState.runtimeType == DateState) {
        add(LoadFilteredTransactions(
            dateState.date, FirebaseAuth.instance.currentUser!.uid));
      } else if (dateState.runtimeType == DateRangeState) {
        final dateRangeState = dateState as DateRangeState;

        add(LoadFilteredRangeTransactions(dateRangeState.startDate,
            dateRangeState.endDate, FirebaseAuth.instance.currentUser!.uid));
      }
    });
    List<Transaction> filterRangeTransaction(
        List<Transaction> transactions, DateTime startDate, DateTime endDate) {
      return transactions
          .where((transaction) =>
              transaction.date
                  .isAfter(startDate.subtract(const Duration(days: 1))) &&
              transaction.date.isBefore(endDate.add(const Duration(days: 1))))
          .toList();
    }

    List<Transaction> filterTransaction(
        List<Transaction> transactions, DateTime date) {
      return transactions
          .where((transaction) =>
              transaction.date.day == date.day &&
              transaction.date.month == date.month &&
              transaction.date.year == date.year)
          .toList();
    }

    Future<List<Transaction>> fetchAndFilterRangeTransactions(
        DateTime startDate, DateTime endDate, String userId) async {
      final transactionsSnapshot =
          await transactionsService.getTransaction(userId);

      final transactionsList = transactionsSnapshot!.docs
          .map((transaction) => Transaction.fromJson(transaction.data()))
          .toList();
      return filterRangeTransaction(transactionsList, startDate, endDate);
    }

    Future<List<Transaction>> fetchAndFilterTransactions(
        DateTime date, String userId) async {
      final transactionsSnapshot =
          await transactionsService.getTransaction(userId);

      final transactionsList = transactionsSnapshot!.docs
          .map((transaction) => Transaction.fromJson(transaction.data()))
          .toList();
      return filterTransaction(transactionsList, date);
    }

    on<LoadFilteredRangeTransactions>(
      (event, emit) async {
        emit(TransactionLoading());
        try {
          final transactions = await fetchAndFilterRangeTransactions(
              event.startDate, event.endDate, event.userId);
          emit(TransactionsLoaded(transactions));
        } catch (e) {}
      },
    );
    on<LoadFilteredTransactions>(
      (event, emit) async {
        emit(TransactionLoading());
        try {
          final transactions =
              await fetchAndFilterTransactions(event.date, event.userId);
          emit(TransactionsLoaded(transactions));
        } catch (e) {}
      },
    );
    on<LoadTransactions>(
      (event, emit) async {
        emit(TransactionLoading());
        try {
          final transactionsSnapshot =
              await transactionsService.getTransaction(event.userId);
          if (transactionsSnapshot != null) {
            final transactionsList = transactionsSnapshot.docs
                .map((transaction) => Transaction.fromJson(transaction.data()))
                .toList();

            emit(TransactionsLoaded(transactionsList));
          } else {
            emit(TransactionFailure('No transactions found'));
          }
        } catch (e) {
          emit(TransactionFailure(e.toString()));
        }
      },
    );
    on<AddTransaction>(
      (event, emit) async {
        emit(TransactionLoading());
        try {
          await transactionsService.addTransaction(
              event.userId, event.transaction.toJson());
          emit(TransactionSuccess());
        } catch (e) {
          TransactionFailure(e.toString());
        }
      },
    );
    on<UpdateTransaction>(
      (event, emit) async {
        emit(TransactionLoading());
        try {
          await transactionsService.updateTransaction(
            event.userId,
            event.transactionId,
            event.transaction.toJson(),
          );
          emit(TransactionSuccess());
        } catch (e) {
          emit(TransactionFailure(e.toString()));
        }
      },
    );
    on<DeleteTransaction>(
      (event, emit) async {
        emit(TransactionLoading());
        try {
          await transactionsService.deleteTransaction(
              event.userId, event.transactionId);
          emit(TransactionSuccess());
        } catch (e) {
          TransactionFailure(e.toString());
        }
      },
    );
  }
}
