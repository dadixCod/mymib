import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymib/core/utils/extensions.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  late PageController pageController;
  late GlobalKey<FormState> revenuesKey;
  late GlobalKey<FormState> expensesKey;

  late TextEditingController dateController;
  late TextEditingController revenuesCategoryController;
  late TextEditingController revenuesAmountController;
  late TextEditingController revenuesNoteController;

  @override
  void initState() {
    pageController = PageController(initialPage: sliderIndex);
    dateController = TextEditingController();
    revenuesCategoryController = TextEditingController();
    revenuesAmountController = TextEditingController();
    revenuesNoteController = TextEditingController();
    revenuesKey = GlobalKey<FormState>();
    expensesKey = GlobalKey<FormState>();
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
          SizedBox(
            height: size.height * 0.6,
            width: size.width * 0.9,
            child: PageView(
              controller: pageController,
              children: [
                RevenuesForm(
                  formKey: revenuesKey,
                  dateController: dateController,
                  category: revenuesCategoryController,
                  amount: revenuesAmountController,
                  note: revenuesNoteController,
                ),
                RevenuesForm(
                  formKey: expensesKey,
                  dateController: dateController,
                  category: revenuesCategoryController,
                  amount: revenuesAmountController,
                  note: revenuesNoteController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RevenuesForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController dateController;
  final TextEditingController category;
  final TextEditingController amount;
  final TextEditingController note;
  const RevenuesForm(
      {super.key,
      required this.formKey,
      required this.dateController,
      required this.category,
      required this.amount,
      required this.note});

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    return Form(
      key: formKey,
      child: Column(
        children: [
          RowTextField(
            text: 'Date',
            controller: dateController,
            suffix: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month),
            ),
          ),
          RowTextField(
            text: 'Montant',
            controller: amount,
            suffix: const SizedBox(),
          ),
          RowTextField(
            text: 'Categorie',
            controller: category,
            suffix: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_list,
              ),
            ),
          ),
          RowTextField(
            text: 'Note',
            controller: note,
            suffix: const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class RowTextField extends StatelessWidget {
  const RowTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.suffix,
  });
  final String text;
  final Widget suffix;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    return SizedBox(
      height: size.height * 0.1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.17,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: context.colorScheme.outline,
              ),
            ),
          ),
          SizedBox(width: size.width * 0.05),
          Container(
            width: size.width * 0.6,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: context.colorScheme.outline.withOpacity(0.5),
                ),
              ),
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffix: suffix,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
