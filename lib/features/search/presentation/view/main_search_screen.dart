// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/dialogs/loading_widget.dart';
import 'package:flowery_app/core/enum/search_type.dart';
import 'package:flowery_app/features/search/presentation/view_model/bloc/search_bloc.dart';
import 'package:flowery_app/features/search/presentation/widget/item_latest_searche.dart';
import 'package:flowery_app/features/search/presentation/widget/results_searches.dart';
import 'package:flowery_app/features/search/presentation/widget/search_init_section.dart';
import 'package:flowery_app/features/search/presentation/widget/search_no_result_section.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchFieldWidget(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        leadingWidth: 35,
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state.isSearchFailure) {
            AppDialogs.showFailureDialog(context, message: state.errorMassage);
          }
        },
        builder: (context, state) {
          print("[UI] BlocBuilder searchType: ${state.searchType}");
          switch (state.searchType) {
            case SearchType.start:
              return SearchInitSection();
            case SearchType.empty:
              return SearchNoResultSection();
            case SearchType.result:
              return ResultsSearches(products: state.products);
            case SearchType.onClick:
              return ItemLatestSearch(
                callBackClickLastSearch: (query) {
                  FocusScope.of(context).unfocus();
                  controller.text = query;
                  context.read<SearchBloc>().add(SearchQueryChanged(query));
                },
              );
          }
        },
      ),
    );
  }

  //* search field
  Widget _searchFieldWidget() {
    context.read<SearchBloc>().state;
    return TextField(
      onChanged: (val) {
        print("[UI] val: $val");
        print("[UI] controller.text: ${controller.text}");
        if (val.trim().isEmpty && controller.text.isEmpty) {
          context.read<SearchBloc>().add(const FetchLatestSearches());
        } else {
          // print("[UI] Dispatch SearchQueryChanged");
          context.read<SearchBloc>().add(SearchQueryChanged(val.trim()));
        }
      },
      onTap: () async {
        context.read<SearchBloc>().add(const FetchLatestSearches());
      },
      onEditingComplete: () {
        FocusScope.of(context).unfocus();

        if (controller.text.isNotEmpty) {
          context.read<SearchBloc>().add(SearchQueryChanged(controller.text));
        }
      },
      controller: controller,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        fillColor: AppColors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white[AppColors.colorCode80]!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white[AppColors.colorCode80]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.all(10),
        hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.white[AppColors.colorCode80],
            ),
        hintText: LocaleKeys.search_enterSearch.tr(),
        prefixIcon: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return IconButton(
              onPressed: state.isSearchLoading
                  ? null
                  : () {
                      if (controller.text.isNotEmpty) {
                        context
                            .read<SearchBloc>()
                            .add(SearchQueryChanged(controller.text));
                      }
                    },
              icon: state.isSearchLoading
                  ? SizedBox(width: 25, height: 25, child: LoadingWidget())
                  : Icon(
                      Icons.search_rounded,
                      color: AppColors.white[AppColors.colorCode80],
                      size: 30,
                    ),
            );
          },
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
            context.read<SearchBloc>().add(const FetchLatestSearches());
          },
          icon: Icon(
            Icons.close_rounded,
            color: AppColors.white[AppColors.colorCode80],
          ),
        ),
      ),
    );
  }

  //! controller
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
