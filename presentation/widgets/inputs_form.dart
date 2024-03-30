import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/presentation/widgets/row_text_field.dart';

class InputsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController dateController;
  final TextEditingController category;
  final TextEditingController amount;
  final TextEditingController note;
  final void Function()? selectCategory;
  const InputsForm({
    super.key,
    required this.formKey,
    required this.dateController,
    required this.category,
    required this.selectCategory,
    required this.amount,
    required this.note,
  });

  @override
  State<InputsForm> createState() => _InputsFormState();
}

class _InputsFormState extends State<InputsForm> {
  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          RowTextField(
            controller: widget.dateController,
            text: 'Date',
            hint: '09/10/2024',
            enabled: false,
            defaultData: widget.dateController.text,
            trailing: IconButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2010),
                  lastDate: DateTime.now().add(
                    const Duration(days: 3652),
                  ),
                  initialDate: DateTime.now(),
                );

                if (selectedDate != null) {
                  setState(() {
                    widget.dateController.text =
                        DateFormat.yMd().format(selectedDate);
                  });
                }
                return;
              },
              icon: const Icon(Icons.calendar_month),
            ),
          ),
          RowTextField(
            controller: widget.amount,
            text: 'Montant (en D.A)',
            hint: '0.00',
            keyboardType: TextInputType.number,
          ),
          RowTextField(
            controller: widget.category,
            text: 'Category',
            hint: 'Autre',
            defaultData: widget.category.text,
            enabled: false,
            trailing: IconButton(
              onPressed: widget.selectCategory,
              icon: const Icon(
                Icons.list_rounded,
              ),
            ),
          ),
          RowTextField(
            controller: widget.note,
            text: 'Note',
            hint: 'Note',
          ),
          SizedBox(height: constants.tenVertical * 5),
        ],
      ),
    );
  }
}