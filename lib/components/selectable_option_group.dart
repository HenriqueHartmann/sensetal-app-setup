import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/selectable_option.dart';

enum SelectionMode { radio, checkbox }

class SelectableOptionItem<T> {
  final T value;
  final String label;

  SelectableOptionItem({required this.value, required this.label});
}

class SelectableOptionGroup<T> extends StatelessWidget {
  final List<SelectableOptionItem<T>> items;
  final SelectionMode mode;
  final T? selectedValue;
  final List<T>? selectedValues;
  final ValueChanged<T> onRadioChanged;
  final ValueChanged<List<T>> onCheckboxChanged;

  const SelectableOptionGroup({
    super.key,
    required this.items,
    required this.mode,
    this.selectedValue,
    this.selectedValues,
    required this.onRadioChanged,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        final isSelected = mode == SelectionMode.radio
            ? item.value == selectedValue
            : selectedValues?.contains(item.value) == true;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SelectableOption<T>(
            value: item.value,
            groupValue: selectedValue,
            label: item.label,
            isSelected: isSelected,
            onChanged: (val) {
              if (mode == SelectionMode.radio) {
                onRadioChanged(val);
              } else {
                final List<T> newValues = [...selectedValues ?? []];
                if (newValues.contains(val)) {
                  newValues.remove(val);
                } else {
                  newValues.add(val);
                }
                onCheckboxChanged(newValues);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
