import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/features/search/data/local_database/last_search_model.dart';
import 'package:flowery_app/features/search/data/local_database/search_last_shared_pref.dart';
import 'package:flowery_app/features/search/presentation/view_model/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/locale_keys.g.dart';

class ItemLatestSearch extends StatefulWidget {
  const ItemLatestSearch({super.key, required this.callBackClickLastSearch});
  final void Function(String backQuery) callBackClickLastSearch;
  @override
  State<ItemLatestSearch> createState() => _ItemLatestSearchState();
}

class _ItemLatestSearchState extends State<ItemLatestSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return state.listLatestSearches.isEmpty
              ? const SizedBox.shrink()
              : Column(
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
                        itemCount: state.listLatestSearches.length > 7
                            ? 5
                            : state.listLatestSearches.length,
                        itemBuilder: (context, index) {
                          return ItemWidgetLatest(
                            item: SearchQuery(
                              id: state.listLatestSearches[index].id,
                              title: state.listLatestSearches[index].title,
                              dateTime: state.listLatestSearches[index].dateTime,
                            ),
                            onPressedDelete: () async {
                              await SearchLastSharedPref.removeQueryById(
                                  state.listLatestSearches[index].id);
                              context.read<SearchBloc>().add(const FetchLatestSearches());
                            },
                            onTap: () {
                              widget.callBackClickLastSearch(
                                  state.listLatestSearches[index].title);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  void _onPressedDeleteAll() {
    AppDialogs.showMessage(
      title: LocaleKeys.search_titleDeleteDialog.tr(),
      message: LocaleKeys.search_desTitleDeleteDialog.tr(),
      titleAction1: LocaleKeys.search_doneDeleteDialog.tr(),
      titleAction2: LocaleKeys.search_cancelDialog.tr(),
      onPressedAction1: () async {
        SearchLastSharedPref.clearAll().then((_) => context.pop());
        context.read<SearchBloc>().add(const FetchLatestSearches());
      },
      onPressedAction2: () {
        context.pop();
      },
      context: context,
      titleStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
      messageStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.gray,
          ),
    );
  }
}

class ItemWidgetLatest extends StatelessWidget {
  const ItemWidgetLatest({
    super.key,
    required this.item,
    required this.onPressedDelete,
    required this.onTap,
  });
  final SearchQuery item;
  final void Function()? onPressedDelete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(5),
      title: Text(
        item.title,
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
