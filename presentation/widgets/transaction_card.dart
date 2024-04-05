import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/data/models/transaction.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_event.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    Constants constants = Constants(deviseSize: deviseSize);
    final autoTexts = S.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/edit_transaction', arguments: transaction);
      },
      child: Dismissible(
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
                content: Text(
                  autoTexts.confirmDeleteTransaction,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      autoTexts.no,
                      style: context.textTheme.bodyLarge,
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
                      autoTexts.yes,
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
          height:
              transaction.expenseAmount != 0 && transaction.revenueAmount != 0
                  ? constants.tenVertical * 12.5
                  : constants.tenVertical * 8.5,
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${transaction.revenueAmount.toString()} ${autoTexts.currency}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "${transaction.expenseAmount.toString()} ${autoTexts.currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.primary,
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
                            transaction.revenueAmount != 0 &&
                                    transaction.expenseAmount == 0
                                ? transaction.revenueCategory
                                : transaction.expenseAmount != 0 &&
                                        transaction.revenueAmount == 0
                                    ? transaction.expenseCategory
                                    : transaction.revenueCategory,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            transaction.revenueAmount != 0 &&
                                    transaction.expenseAmount == 0
                                ? "${transaction.revenueAmount.toString()} ${autoTexts.currency}"
                                : transaction.expenseAmount != 0 &&
                                        transaction.revenueAmount == 0
                                    ? "${transaction.expenseAmount.toString()} ${autoTexts.currency}"
                                    : "${transaction.revenueAmount.toString()} ${autoTexts.currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: transaction.revenueAmount != 0 &&
                                      transaction.expenseAmount == 0
                                  ? Colors.blue
                                  : transaction.expenseAmount != 0 &&
                                          transaction.revenueAmount == 0
                                      ? context.colorScheme.primary
                                      : Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    transaction.expenseAmount != 0 &&
                            transaction.revenueAmount != 0
                        ? Divider(
                            height: 1,
                            color: context.colorScheme.outline.withOpacity(0.2),
                          )
                        : const SizedBox(),
                    transaction.expenseAmount != 0 &&
                            transaction.revenueAmount != 0
                        ? Padding(
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
                                  "${transaction.expenseAmount.toString()} ${autoTexts.currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
