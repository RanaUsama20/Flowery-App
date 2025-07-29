import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/utils/widgets/card.dart';
import 'package:flowery_app/features/home/presentation/view/occasion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../product_details/presentation/models/product_details_model.dart';
import '../../domain/entity/get_products_by_id_entity.dart';
import '../view_model/categories_cubit.dart';
import '../widgets/bottom_sheet.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _indexCategory = 0;
  String sortSort = '';
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          spacing: 10,
          children: [
            _topSectionSearch(),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              buildWhen: (previous, current) =>
                  previous.isCategoriesLoading != current.isCategoriesLoading,
              builder: (context, state) {
                if (state.isCategoriesLoading || state.isCategoriesFailure) {
                  return _buildDummyTabBar();
                }
                return _buildTabBar(
                  state.categories.map((e) => Tab(text: e.name)).toList(),
                  (index) {
                    _indexCategory = index;
                    context
                        .read<CategoriesCubit>()
                        .getProductsByCategory(state.categories[index].id);
                  },
                );
              },
            ),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state.isProductsLoading || state.isProductsFailure) {
                  return _buildDummyProductOfCategory();
                }
                if (state.products.isEmpty) {
                  return _buildDummyProductOfCategory();
                }
                return state.resultSearchProducts.isEmpty
                    ? _buildProductsOfCategory(state.products)
                    : _buildProductsOfCategory(state.resultSearchProducts);
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: MaterialButton(
        onPressed: () {
          showFilterSheet(context.read<CategoriesCubit>());
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: AppColors.pink,
        child: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.Home_Filter.tr(),
              style: AppTheme.lightTheme.textTheme.labelSmall,
            ),
            const Icon(Icons.tune, color: AppColors.white)
          ],
        ),
      ),
    );
  }

  Row _topSectionSearch() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            onChanged: (query) {
              context.read<CategoriesCubit>().searchProduct(query);
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.pink),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.gray),
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.gray,
              ),
              hintText: LocaleKeys.Home_Search.tr(),
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.gray),
          ),
          child: IconButton(
            icon: Icon(Icons.filter_list, color: AppColors.gray),
            onPressed: () {
              showFilterSheet(context.read<CategoriesCubit>());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(List<Tab> tabs, Function(int index) callBack) {
    return DefaultTabController(
      length: tabs.length,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        onTap: (value) => callBack(value),
        isScrollable: true,
        tabs: tabs,
      ),
    );
  }

  Widget _buildProductsOfCategory(List<ProductsOfCategoryEntity> products) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 260,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.productDetails,
                arguments: ProductDetailsModel(
                  id: products[index].id.toString(),
                  price: products[index].price?.toInt() ?? 0,
                  description: products[index].description ?? "",
                  name: products[index].title ?? "",
                  images: products[index].images ?? [],
                  inStock: (products[index].quantity)! > 0 ? true : false,
                ),
              );
            },
            child: ProductCard.createProductCard(
              products[index].imgCover.toString(),
              products[index].title.toString(),
              products[index].priceAfterDiscount?.toInt() ?? 0,
              products[index].price?.toInt() ?? 0,
              products[index].discount?.toInt() ?? 0,
              onAddToCart: () {},
              productId: products[index].id.toString(),
            ),
          );
        },
      ),
    );
  }

  void showFilterSheet(CategoriesCubit cubit) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return FilterSheetContent(
          onPressed: () async {
            context.pop();
            await cubit.filterProduct(
              cubit.state.categories[_indexCategory].id,
              sortSort,
            );
          },
          onSort: (sort) {
            sortSort = sort ?? 'price';
          },
        );
      },
    );
  }

  Widget _buildDummyProductOfCategory() {
    return Expanded(
      child: Skeletonizer(
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 260,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) => ProductCard.createProductCard(
            imageDummy,
            "Hello User",
            32,
            35,
            30,
            onAddToCart: () {},
            productId: '',
          ),
        ),
      ),
    );
  }

  Widget _buildDummyTabBar() {
    return Skeletonizer(
      enabled: true,
      child: DefaultTabController(
        length: 10,
        child: TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(text: 'Wedding'),
            Tab(text: 'Graduation'),
            Tab(text: 'Birthday'),
            Tab(text: 'Katb Ketab'),
            Tab(text: 'Engagement'),
            Tab(text: 'Thank you'),
            Tab(text: 'Get well'),
            Tab(text: 'Wedding'),
            Tab(text: 'Engagement'),
            Tab(text: 'Birthday'),
          ],
        ),
      ),
    );
  }
}
