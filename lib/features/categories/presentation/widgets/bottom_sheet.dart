import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';

class FilterSheetContent extends StatefulWidget {
  const FilterSheetContent({super.key, this.onPressed, required this.onSort});
  final void Function()? onPressed;
  final void Function(String?) onSort;
  @override
  State<FilterSheetContent> createState() => _FilterSheetContentState();
}

class _FilterSheetContentState extends State<FilterSheetContent> {
  String? selectedSort;

  final sortOptions = {
    "Lowest Price": "price",
    "Highest Price": "-price",
    "New": "-createdAt",
    "Old": "createdAt",
    "Discount": "discount",
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.Home_SortBy.tr(),
            style: AppTheme.lightTheme.textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          ...sortOptions.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: RadioListTile<String>(
                  title: Text(
                    style: AppTheme.lightTheme.textTheme.titleSmall,
                    entry.key,
                    textAlign: TextAlign.left,
                  ),
                  value: entry.value,
                  groupValue: selectedSort,
                  activeColor: AppColors.pink,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  onChanged: (value) {
                    widget.onSort(value);
                    setState(() => selectedSort = value);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: widget.onPressed,
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.tune, size: 20, color: Colors.white),
                Text(
                  LocaleKeys.Home_Filter.tr(),
                  style: AppTheme.lightTheme.textTheme.titleSmall
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
