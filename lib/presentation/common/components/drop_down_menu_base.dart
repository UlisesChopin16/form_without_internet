import 'package:flutter/material.dart';

typedef ValueChanged<T> = void Function(T? value);

class DropDownMenuBase<T> extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<T> onSelected;
  final void Function()? onClear;
  final bool activateClean;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final TextStyle? textStyle;
  final String label;
  const DropDownMenuBase({
    super.key,
    required this.controller,
    required this.onSelected,
    required this.dropdownMenuEntries,
    required this.label,
    required this.activateClean,
    this.onClear,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      controller: controller,
      onSelected: onSelected,
      textStyle: textStyle ??
          const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
      leadingIcon: !activateClean
          ? null
          : IconButton(
              // circle cross icon to clear the filter
              icon: const Icon(
                Icons.cancel_rounded,
                color: Colors.red,
              ),
              onPressed: onClear,
            ),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
