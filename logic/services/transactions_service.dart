// ignore_for_file: unused_catch_clause

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>?> getTransaction(
    String userId,
  ) async {
    try {
      final transactionQuerySnapshot = await firestore
          .collection('transactions')
          .doc(userId)
          .collection('user_transactions')
          .orderBy(
            'date',
            descending: true,
          )
          .get();

      return transactionQuerySnapshot;
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTransaction(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      String transactionId = firestore
          .collection('transactions')
          .doc(userId)
          .collection('user_transactions')
          .doc()
          .id;
      data['id'] = transactionId;
      await firestore
          .collection('transactions')
          .doc(userId)
          .collection('user_transactions')
          .doc(transactionId)
          .set(data);
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTransaction(
    String userId,
    String transactionId,
    Map<String, dynamic> data,
  ) async {
    await firestore
        .collection('transactions')
        .doc(userId)
        .collection('user_transactions')
        .doc(transactionId)
        .update(data);
  }

  Future<void> deleteTransaction(
    String userId, // The ID of the current user
    String transactionId,
  ) async {
    try {
      await firestore
          .collection('transactions')
          .doc(userId)
          .collection('user_transactions')
          .doc(transactionId)
          .delete();
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      log('Error deleting transaction: $e');
      rethrow;
    }
  }
}
