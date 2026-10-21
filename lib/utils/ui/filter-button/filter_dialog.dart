import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/utils/ui/custom_dual_button.dart';

class FilterGroupSpec {
  const FilterGroupSpec(this.title, this.options, this.selected);

  final String title;
  final List<String> options;
  final int selected;
}

class FilterDialog {
  static Future<List<int>?> show({
    required String title,
    required List<FilterGroupSpec> groups,
  }) {
    return Get.dialog<List<int>>(
      _FilterDialogView(title: title, groups: groups),
    );
  }
}

class _FilterDialogView extends StatefulWidget {
  const _FilterDialogView({required this.title, required this.groups});

  final String title;
  final List<FilterGroupSpec> groups;

  @override
  State<_FilterDialogView> createState() => _FilterDialogViewState();
}

class _FilterDialogViewState extends State<_FilterDialogView> {
  late final List<int> selected = widget.groups.map((g) => g.selected).toList();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors().baseColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: AppColors().accentColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (var g = 0; g < widget.groups.length; g++) ...[
              const SizedBox(height: 18),
              Text(
                widget.groups[g].title,
                style: TextStyle(
                  color: AppColors().textFieldLabelColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              for (var i = 0; i < widget.groups[g].options.length; i++)
                _radioRow(
                  label: widget.groups[g].options[i],
                  isSelected: selected[g] == i,
                  onTap: () => setState(() => selected[g] = i),
                ),
            ],
            const SizedBox(height: 22),

            CustomDualButton(
              cancelText: 'Reset',
              confirmText: 'Apply',
              onCancel: () {
                Get.back(result: List<int>.filled(widget.groups.length, 0));
              },
              onConfirm: () {
                Get.back(result: List<int>.of(selected));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _radioRow({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? AppColors().buttonWithBackground
                  : AppColors().textFieldLabelColor,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
