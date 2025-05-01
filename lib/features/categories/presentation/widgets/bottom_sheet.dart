import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';
import '../view_model/cubit/categories_cubit.dart';

void showFilterSheet(BuildContext context, CategoriesCubit cubit) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: const FilterSheetContent(),
      );
    },
  );

}

class FilterSheetContent extends StatefulWidget {
  const FilterSheetContent({super.key});

  @override
  State<FilterSheetContent> createState() => _FilterSheetContentState();
}

class _FilterSheetContentState extends State<FilterSheetContent> {
  String? selectedSort;


  final Map<String, String> sortOptions = {
    "Lowes Price": "price",
    "Highest Price": "-price",
    "New": "-createdAt",
    "Old": "createdAt",
    "Discount": "discount",
  };

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    LocaleKeys.Home_SortBy.tr(),
                    style: AppTheme.lightTheme.textTheme.labelLarge
                ),
                const SizedBox(height: 12),
                ...sortOptions.entries.map(
                      (entry) => Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        onChanged: (value) {
                          setState(() => selectedSort = value);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    final isLoading = state is CategoriesLoading;

                return ElevatedButton.icon(
                  onPressed: isLoading || selectedSort == null
                      ? null
                      : () {
                    final cubit = context.read<CategoriesCubit>();
                    final currentState = cubit.state;

                    if (currentState is SuccessState) {
                      cubit.filterToProducts(
                        categoryId: currentState.currentCategoryId,
                        sort: selectedSort!,
                      );
                    }
                    Navigator.pop(context);
                  },

                  icon: isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.tune, size: 20),
                  label: Text(isLoading
                      ? LocaleKeys.Loading.tr()
                      : LocaleKeys.Home_Filter.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                );
              },
            ),
          ],
        ));
      },
    );
  }
}

