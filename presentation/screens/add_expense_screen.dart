// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/data/models/category.dart';
import 'package:mymib/presentation/widgets/custom_segmented_button.dart';
import 'package:mymib/presentation/widgets/fancy_rounded_button.dart';
import 'package:mymib/presentation/widgets/inputs_form.dart';
// import 'package:mymib/data/models/category.dart';

import '../../logic/blocs/categories_bloc.dart/bloc/category_bloc.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  var date = DateTime.now();

  late PageController pageController;
  late GlobalKey<FormState> revenuesKey;
  late GlobalKey<FormState> expensesKey;
  var currentRevIndex = 0;
  var currentExpIndex = 0;
  late TextEditingController dateController;
  late TextEditingController revenuesCategoryController;
  late TextEditingController revenuesAmountController;
  late TextEditingController revenuesNoteController;
  late TextEditingController expensesCategoryController;
  late TextEditingController expensesAmountController;
  late TextEditingController expensesNoteController;
  late String selectedRevCategory;
  late String selectedExpCategory;
  @override
  void initState() {
    pageController = PageController(initialPage: sliderIndex);
    dateController = TextEditingController();
    expensesCategoryController = TextEditingController();
    expensesAmountController = TextEditingController();
    expensesNoteController = TextEditingController();
    revenuesCategoryController = TextEditingController();
    revenuesAmountController = TextEditingController();
    revenuesNoteController = TextEditingController();
    var formattedDate = DateFormat.yMd().format(date);
    dateController.text = formattedDate;
    revenuesKey = GlobalKey<FormState>();
    expensesKey = GlobalKey<FormState>();
    selectedRevCategory =
        context.read<CategoryBloc>().state.revenueCategories[0].category;
    revenuesCategoryController.text = selectedRevCategory;
    selectedExpCategory =
        context.read<CategoryBloc>().state.expensesCategories[0].category;
    expensesCategoryController.text = selectedExpCategory;
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    dateController.dispose();
    revenuesCategoryController.dispose();
    revenuesAmountController.dispose();
    revenuesNoteController.dispose();
    super.dispose();
  }

  var sliderIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        title: const Text(
          'Revenus',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: CupertinoSlidingSegmentedControl(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              backgroundColor: Colors.transparent,
              thumbColor:
                  sliderIndex == 0 ? Colors.blue : context.colorScheme.primary,
              groupValue: sliderIndex,
              children: {
                0: const Text(
                  "Revenus",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                1: Text(
                  "Dépenses",
                  style: TextStyle(
                    color: sliderIndex == 1
                        ? context.colorScheme.background
                        : context.colorScheme.inverseSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              },
              onValueChanged: (index) {
                setState(() {
                  if (index == 1) {
                    sliderIndex = index!;
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                    );
                  } else if (index == 0) {
                    sliderIndex = index!;
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                    );
                  }
                });
              },
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
            return SizedBox(
              height: size.height * 0.52,
              width: size.width * 0.9,
              child: PageView(
                controller: pageController,
                children: [
                  //revenues

                  InputsForm(
                    formKey: revenuesKey,
                    dateController: dateController,
                    category: revenuesCategoryController,
                    selectCategory: () {
                      chooseCategorySheet(
                        context,
                        size,
                        state.revenueCategories,
                        revenuesCategoryController,
                        currentRevIndex,
                        selectedRevCategory,
                        true,
                      );
                    },
                    amount: revenuesAmountController,
                    note: revenuesNoteController,
                  ),

                  InputsForm(
                    formKey: expensesKey,
                    dateController: dateController,
                    category: expensesCategoryController,
                    selectCategory: () {
                      chooseCategorySheet(
                        context,
                        size,
                        state.expensesCategories,
                        expensesCategoryController,
                        currentExpIndex,
                        selectedExpCategory,
                        false,
                      );
                    },
                    amount: expensesAmountController,
                    note: expensesNoteController,
                  ),
                ],
              ),
            );
          }),
          FancyRoundedButton(
            onTap: () {
              double? revAmount;
              double? expAmount;
              if ((revenuesAmountController.text.isEmpty &&
                      expensesAmountController.text.isNotEmpty) ||
                  (revenuesAmountController.text.isNotEmpty &&
                      expensesAmountController.text.isEmpty)) {
                if (revenuesAmountController.text.isNotEmpty) {
                  revAmount = double.tryParse(revenuesAmountController.text);
                }
                if (expensesAmountController.text.isNotEmpty) {
                  expAmount = double.tryParse(revenuesAmountController.text);
                }
              }
            },
            text: 'Enregistrer',
            color: Colors.blueAccent,
          )
        ],
      ),
    );
  }

  Future<dynamic> chooseCategorySheet(
    BuildContext context,
    Size size,
    List<Category> list,
    TextEditingController controller,
    int widgetIndex,
    String selectedCategory,
    bool isRev,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: size.height * 0.5,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/edit_categories',
                    arguments: isRev,
                  );
                },
                child: Container(
                  width: size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: context.colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.edit_rounded,
                        size: 22,
                      ),
                      Text(
                        "Editer",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomSegmentedButton(
                items: list,
                selectedIndex: widgetIndex, // Provide the selectedIndex
                onSelectionChanged: (index) {
                  selectedCategory = list[index].category;
                  setState(() {
                    controller.text = selectedCategory;
                  });
                  widgetIndex = index; // Update the currentIndex
                },
              )
            ],
          ),
        );
      },
    );
  }
}
