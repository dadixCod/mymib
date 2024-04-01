import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymib/core/utils/extensions.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Set<String> selected = {};
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    final List<Color> colors = [
      Colors.deepOrange,
      Colors.orange,
      Colors.amber,
      Colors.green,
    ];
    final List<double> values = [
      40,
      30,
      20,
      10,
    ];
    final List<double> valuesExpenses = [
      45,
      25,
      20,
      10,
    ];
    final List<String> categories = [
      'Freelance',
      'Salaire',
      'Bourse',
      'Autre',
    ];
    final List<String> categoriesExpenses = [
      'Transport',
      'Etudes',
      'Sport',
      'Autre',
    ];
    final List<double> amounts = [
      95000,
      40000,
      20000,
      1000,
    ];
    final List<double> amountsExpenses = [
      20000,
      10000,
      8000,
      4000,
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistiques',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
            children: [
              selectedDate == null
                  ? const SizedBox()
                  : Text(
                      DateFormat.Md().format(selectedDate!),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              IconButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(
                      const Duration(days: 3650),
                    ),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      selected = {};
                      selectedDate = date;
                    });
                  }
                  return;
                },
                icon: const Icon(
                  Icons.calendar_month,
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: deviseSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.only(bottom: 10),
              child: SegmentedButton(
                emptySelectionAllowed: true,
                onSelectionChanged: (newSelection) {
                  setState(() {
                    selected = newSelection;
                    selectedDate = null;
                  });
                },
                segments: const [
                  ButtonSegment(
                    value: 'Semaine',
                    label: Text(
                      'Semaine',
                    ),
                  ),
                  ButtonSegment(
                    value: 'Mois',
                    label: Text(
                      'Mois',
                    ),
                  ),
                  ButtonSegment(
                    value: 'Année',
                    label: Text(
                      'Année',
                    ),
                  ),
                ],
                selected: selected,
              ),
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Revenus'),
                      Tab(text: 'Dépenses'),
                    ],
                  ),
                  SizedBox(
                    height: deviseSize.height * 0.8,
                    child: TabBarView(
                      children: [
                        StatisticsView(
                          deviseSize: deviseSize,
                          values: values,
                          categories: categories,
                          colors: colors,
                          amounts: amounts,
                        ),
                        StatisticsView(
                          deviseSize: deviseSize,
                          values: valuesExpenses,
                          categories: categoriesExpenses,
                          colors: colors,
                          amounts: amountsExpenses,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StatisticsView extends StatelessWidget {
  const StatisticsView({
    super.key,
    required this.deviseSize,
    required this.values,
    required this.categories,
    required this.colors,
    required this.amounts,
  });

  final Size deviseSize;
  final List<double> values;
  final List<String> categories;
  final List<Color> colors;
  final List<double> amounts;

  @override
  Widget build(BuildContext context) {
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
                  4,
                  (index) => PieChartSectionData(
                    value: values[index] / 100,
                    title: categories[index],
                    titlePositionPercentageOffset: 0.6,
                    color: colors[index],
                    titleStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    radius: 100,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: deviseSize.height * 0.01),
        SizedBox(
          height: deviseSize.height * 0.3,
          child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: context.colorScheme.outline.withOpacity(0.3),
                );
              },
              itemBuilder: (context, index) {
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
                          color: colors[index],
                        ),
                        child: Center(
                          child: Text(
                            "${values[index]}%",
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
                          categories[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${amounts[index]} DA',
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
