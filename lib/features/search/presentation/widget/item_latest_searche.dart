import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/search/presentation/view_model/search_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';

class ItemLatestSearch extends StatelessWidget {
  const ItemLatestSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  LocaleKeys.search_lastSearch.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _onPressedDeleteAll,
                  child: Text(
                    LocaleKeys.search_deleteAll.tr(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return ItemWidgetLatest(
                  item: Item(itemId: 1, itemTitle: "Flowers"),
                  onPressedDelete: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onPressedDeleteAll() {
    // AppDialog.showMessage(
    //   title: LocaleKeys.search_titleDeleteDialog.tr(),
    //   message: LocaleKeys.search_desTitleDeleteDialog.tr(),
    //   titleAction1: LocaleKeys.search_doneDeleteDialog.tr(),
    //   titleAction2: LocaleKeys.search_cancelDialog.tr(),
    //   onPressedAction1: () {},
    //   onPressedAction2: () {
    //     context.pop();
    //   },
    //   context: context,
    //   titleStyle: AppTextStyle.size18.copyWith(
    //     fontWeight: FontWeight.bold,
    //   ),
    //   messageStyle: AppTextStyle.size14.copyWith(
    //     color: AppColor.gray,
    //   ),
    // );
  }
}

class ItemWidgetLatest extends StatelessWidget {
  const ItemWidgetLatest({
    super.key,
    required this.item,
    required this.onPressedDelete,
  });
  final Item item;
  final void Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(5),
      title: Text(
        item.itemTitle,
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.close,
          color: AppColors.gray,
        ),
        onPressed: onPressedDelete,
      ),
      leading: const Icon(
        Icons.history,
        color: AppColors.black,
      ),
    );
  }
}
