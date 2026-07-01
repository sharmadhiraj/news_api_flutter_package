import 'package:flutter/material.dart';

/// A labeled dropdown for picking an optional enum value, e.g. [NewsCountry] or
/// [NewsCategory]. Selecting "Any" clears the filter.
class EnumDropdown<T extends Enum> extends StatelessWidget {
  const EnumDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
    super.key,
  });

  final String label;
  final T? value;
  final List<T> values;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T?>(
          value: value,
          isExpanded: true,
          items: <DropdownMenuItem<T?>>[
            DropdownMenuItem<T?>(value: null, child: const Text("Any")),
            ...values.map(
              (v) => DropdownMenuItem<T?>(
                value: v,
                child: Text(v.name, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
