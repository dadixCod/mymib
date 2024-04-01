import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/data/models/transaction.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_event.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    Constants constants = Constants(deviseSize: deviseSize);
    // DateTime date = DateTime.parse(transaction.date);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: context.colorScheme.error,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        var delete = false;
        if (direction == DismissDirection.endToStart) {
          await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text(
                "Voulez - vous supprimer cette transaction?",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Non",
                    style: context.textTheme.bodyLarge?.copyWith(
                        // color: context.colorScheme.error,

                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    delete = true;
                    context.read<TransactionsBloc>().add(
                          DeleteTransaction(
                              FirebaseAuth.instance.currentUser!.uid,
                              transaction.id!),
                        );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Oui",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return delete;
      },
      child: Container(
        width: deviseSize.width * 0.9,
        height: constants.tenVertical * 8,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.background,
        ),
        child: Row(
          children: [
            Container(
              width: deviseSize.width * 0.1,
              height: deviseSize.height,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
              ),
              clipBehavior: Clip.hardEdge,
              child: Center(
                child: Text(
                  transaction.date.day.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: deviseSize.width * 0.79,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transaction.revenueCategory,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${transaction.revenueAmount.toString()} DA",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: context.colorScheme.outline,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transaction.expenseCategory,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${transaction.expenseAmount.toString()} DA",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
