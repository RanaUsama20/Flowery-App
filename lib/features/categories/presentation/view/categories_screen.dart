import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/enum/state_user.dart';
import 'package:flowery_app/core/utils/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';
import '../../../product_details/presentation/models/product_details_model.dart';
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
  final ScrollController _scrollController = ScrollController();

  int selectedIndex = 0;
  bool _showFilterButton = true;
  late AppCubit _appCubit;

  @override
  void initState() {
    super.initState();
    _appCubit = serviceLocator.get<AppCubit>();
    categories.getAllCategories();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_showFilterButton) setState(() => _showFilterButton = false);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_showFilterButton) setState(() => _showFilterButton = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              return Center(child: Text(LocaleKeys.Error.tr()));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildBody(
      List<CategoriesEntity> allCategories, List<ProductsEntity> products) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(Routes.search);
                          },
                          child: TextFormField(
                            enabled: false,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ) ,
                              labelText: LocaleKeys.Home_Search.tr(),
                              hintText: LocaleKeys.Home_Search.tr(),
                              prefixIcon: const Icon(Icons.search),
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onTapOutside: (_) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
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
                          categories
                              .getProductsById(allCategories[index].id ?? "");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                allCategories[index].name ?? '',
                                style: AppTheme.lightTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  color: isSelected
                                      ? AppColors.pink
                                      : AppColors.gray,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 2,
                                width: 40,
                                color: isSelected
                                    ? AppColors.pink
                                    : AppColors.gray,
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
                      ? Center(
                          child: Text(
                            LocaleKeys.Home_NoProductsInThiSection.tr(),
                            style: AppTheme.lightTheme.textTheme.titleSmall,
                          ),
                        )
                      : GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 260,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final mappedProduct = ProductDetailsModel(
                              id: products[index].id.toString(),
                              price: products[index].price!.toInt(),
                              description: products[index].description!,
                              name: products[index].title!,
                              images: products[index].images!,
                              inStock: products[index].quantity != null
                                  ? true
                                  : false,
                            );
                            return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.productDetails,
                                      arguments: mappedProduct);
                                },
                                child: BlocProvider(
                                    create: (context) =>
                                        serviceLocator<CartCubit>(),
                                    child: BlocConsumer<CartCubit, CartState>(
                                      builder: (context, state) {
                                        final cartCubit =
                                            context.read<CartCubit>();
                                        return ProductCard.createProductCard(
                                          products[index].imgCover.toString(),
                                          products[index].title.toString(),
                                          products[index]
                                                  .priceAfterDiscount
                                                  ?.toInt() ??
                                              0,
                                          products[index].price?.toInt() ?? 0,
                                          products[index].discount?.toInt() ??
                                              0,
                                          onAddToCart: () {
                                            if (_appCubit.getStateUser ==
                                                StateUser.guest) {
                                              AppDialogs.showLoginDialog(
                                                  context,
                                                  message: LocaleKeys
                                                          .Error_YouHaveToLoginToUseThisFeature
                                                      .tr());
                                            } else {
                                              cartCubit.addProductToCart(
                                                  products[index].id.toString(),
                                                  1);
                                            }
                                          },
                                          productId:
                                              products[index].id.toString(),
                                        );
                                      },
                                      listener: (BuildContext context,
                                          CartState state) {
                                        if (state is CartSuccessState) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: AppColors.green,
                                              content: Text(
                                                state.productCart.message
                                                    .toString(),
                                                style: AppTheme.lightTheme
                                                    .textTheme.labelSmall,
                                              ),
                                            ),
                                          );
                                        } else if (state is CartErrorState) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: AppColors.red,
                                              content: Text(
                                                LocaleKeys.Error_SoldOut.tr(),
                                                style: AppTheme.lightTheme
                                                    .textTheme.labelSmall,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    )));
                          },
                        ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: _showFilterButton ? Offset.zero : const Offset(0, 2),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _showFilterButton ? 1.0 : 0.0,
                  child: ElevatedButton.icon(
                    style:
                        AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                      fixedSize: MaterialStatePropertyAll(const Size(120, 50)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: MaterialStatePropertyAll(EdgeInsets.all(6)),
                    ),
                    onPressed: () {
                      // Filter action
                    },
                    icon: const Icon(Icons.tune, color: AppColors.white),
                    label: Text(LocaleKeys.Home_Filter.tr(),
                        style: AppTheme.lightTheme.textTheme.labelSmall),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
