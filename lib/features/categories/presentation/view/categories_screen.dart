import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/utils/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../domain/entity/get_all_categories_entity.dart';
import '../../domain/entity/get_products_by_id_entity.dart';
import '../view_model/cubit/categories_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesCubit categories = serviceLocator<CategoriesCubit>();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    categories.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categories,
      child: Scaffold(
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SuccessState) {
              return buildBody(state.allCategories ?? [], state.products ?? []);
            } else if (state is CategoriesError) {
              return Center(
                  child: Text(
                LocaleKeys.Error.tr(),
              ));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildBody(
      List<CategoriesEntity> allCategories, List<ProductsEntity> products) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          labelText: LocaleKeys.Home_Search.tr(),
                          hintText: LocaleKeys.Home_Search.tr(),
                          prefixIcon: const Icon(Icons.search),
                          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12))),
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height:50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.gray),
                    ),
                    child: IconButton(
                      icon:  Icon(Icons.filter_list, color: AppColors.gray),
                      onPressed: () {},
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allCategories.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      categories.getProductsById(allCategories[index].id ?? "");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            allCategories[index].name ?? '',
                            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(color:  isSelected
                                ? AppColors.pink
                                : AppColors.gray,fontWeight: FontWeight.w400),
                            ),

                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 40,
                              color:  isSelected
                                  ? AppColors.pink
                                  : AppColors.gray
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: products.isEmpty
                  ?  Center(
                      child: Text(
                        LocaleKeys.Home_products.tr(),
                        style: AppTheme.lightTheme.textTheme.titleSmall,  ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 260,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard.createProductCard(
                          products[index].imgCover.toString(),
                          products[index].title.toString(),
                          products[index].priceAfterDiscount?.toInt() ?? 0,
                          products[index].price?.toInt() ?? 0,
                          products[index].discount?.toInt() ?? 0,
                          actionButton: ActionButton(onPressed: () {}),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
