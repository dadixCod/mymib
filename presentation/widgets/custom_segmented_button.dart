import 'package:flutter/material.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/data/models/category.dart';

class CustomSegmentedButton extends StatefulWidget {
  final List<Category> items;
  final double containerWidth;
  final int? selectedIndex; // New parameter
  final void Function(int)? onSelectionChanged;

  const CustomSegmentedButton({
    super.key,
    required this.items,
    this.containerWidth = 100.0,
    this.selectedIndex, // Initialize selectedIndex
    this.onSelectionChanged,
  });

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? -1; // Initialize _selectedIndex
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: List.generate(
        widget.items.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            widget.onSelectionChanged?.call(index);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.containerWidth,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? context.colorScheme.primary
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                widget.items[index].category,
                style: TextStyle(
                  color: _selectedIndex == index ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
