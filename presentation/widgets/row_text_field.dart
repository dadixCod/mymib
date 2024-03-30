import 'package:flutter/material.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';

class RowTextField extends StatelessWidget {
  const RowTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.hint,
    this.trailing,
    this.suffix,
    this.enabled = true,
    this.keyboardType,
    this.defaultData,
  });
  final String text;
  final String hint;
  final String? defaultData;
  final Widget? trailing;
  final Widget? suffix;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    final Constants constants = Constants(deviseSize: deviseSize);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
          ),
          SizedBox(height: constants.tenVertical * 0.5),
          Container(
            height: deviseSize.height * 0.065,
            width: deviseSize.width,
            padding: const EdgeInsets.only(
              left: 15,
              right: 10,
              bottom: 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.colorScheme.outline,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: deviseSize.width * 0.65,
                  child: enabled
                      ? TextFormField(
                          controller: controller,
                          keyboardType: keyboardType,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: hint,
                            border: InputBorder.none,
                            // suffix: suffix,
                          ),
                        )
                      : Text(
                          defaultData != null ? defaultData! : '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                trailing == null ? const SizedBox() : trailing!
              ],
            ),
          ),
        ],
      ),
    );
  }
}
