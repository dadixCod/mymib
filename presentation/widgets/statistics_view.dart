import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({
    super.key,
    required this.deviseSize,
    required this.categories,
    required this.amount,
    required this.isExpensesList,
  });

  final Size deviseSize;

  final Map<String, double> categories;
  final bool isExpensesList;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final autoTexts = S.of(context);
    Color getColorForCategory(
      double categoryFraction,
      bool isExpensesList,
    ) {
      if (isExpensesList) {
        if (categoryFraction >= 0.6) {
          return Colors.red;
        } else if (categoryFraction >= 0.5 && categoryFraction < 0.6) {
          return Colors.deepOrange;
        } else if (categoryFraction >= 0.4 && categoryFraction < 0.5) {
          return Colors.orange;
        } else if (categoryFraction >= 0.3 && categoryFraction < 0.4) {
          return Colors.amber;
        } else if (categoryFraction >= 0.2 && categoryFraction < 0.3) {
          return Colors.green;
        } else {
          return Colors.blue;
        }
      } else {
        // Colors for revenues list (reversed)
        if (categoryFraction >= 0.6) {
          return Colors.blue;
        } else if (categoryFraction >= 0.5 && categoryFraction < 0.6) {
          return Colors.green;
        } else if (categoryFraction >= 0.4 && categoryFraction < 0.5) {
          return Colors.amber;
        } else if (categoryFraction >= 0.3 && categoryFraction < 0.4) {
          return Colors.orange;
        } else if (categoryFraction >= 0.2 && categoryFraction < 0.3) {
          return Colors.deepOrange;
        } else {
          return Colors.red;
        }
      }
    }

    return Column(
      children: [
        Container(
          height: deviseSize.height * 0.4,
          width: deviseSize.width,
          padding: const EdgeInsets.symmetric(vertical: 30),
          color: context.colorScheme.primaryContainer.withOpacity(0.3),
          child: Center(
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 0,
                sectionsSpace: 2,
                sections: List.generate(
                  categories.length,
                  (index) {
                    final categoryFraction =
                        categories.values.elementAt(index) / amount;
                    return PieChartSectionData(
                      value: categories.values.elementAt(index) / amount,
                      title: categories.keys.elementAt(index),
                      titlePositionPercentageOffset: 0.6,
                      color:
                          getColorForCategory(categoryFraction, isExpensesList),
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      radius: 100,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: deviseSize.height * 0.01),
        SizedBox(
          height: deviseSize.height * 0.3,
          child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: context.colorScheme.outline.withOpacity(0.3),
                );
              },
              itemBuilder: (context, index) {
                final sortedEntries = categories.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));

                final sortedCategories =
                    sortedEntries.map((entry) => entry.key).toList();
                final sortedAmounts =
                    sortedEntries.map((entry) => entry.value).toList();

                final category = sortedCategories[index];
                final amountSorted = sortedAmounts[index];
                final categoryFraction = amountSorted / amount;
                return Container(
                  height: deviseSize.height * 0.07,
                  width: deviseSize.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  color: context.colorScheme.primaryContainer.withOpacity(0.4),
                  child: Row(
                    children: [
                      Container(
                        height: deviseSize.height * 0.035,
                        width: deviseSize.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: getColorForCategory(
                              categoryFraction, isExpensesList),
                        ),
                        child: Center(
                          child: Text(
                            "${(((amountSorted / amount) * 100).round())}%",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.background,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: deviseSize.width * 0.02),
                      Expanded(
                        child: Text(
                          category,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${categories.values.elementAt(index)} ${autoTexts.currency}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
