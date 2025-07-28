import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart';
import 'package:flowery_app/core/enum/state_user.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/widgets/card.dart';
import 'package:flowery_app/features/home/presentation/view/occasion_screen.dart';
import 'package:flowery_app/features/home/presentation/view_model/best_seller/best_seller_cubit.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/base_state/base_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/widgets/error_widget.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';
import '../../domain/entity/best_seller_response_entity.dart';
import '../view_model/best_seller/best_seller_state.dart';

class BestSellerBody extends StatefulWidget {
  const BestSellerBody({super.key});

  @override
  State<BestSellerBody> createState() => _BestSellerBodyState();
}

class _BestSellerBodyState extends State<BestSellerBody> {
  late BestSellerCubit cubit;
  late AppCubit _appCubit;
  @override
  void initState() {
    super.initState();
    _appCubit = serviceLocator<AppCubit>();
    cubit = serviceLocator<BestSellerCubit>();
    cubit.doIntent(GetDataAction());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<BestSellerCubit, BestSellerState>(
        listenWhen: (previous, current) => current.selectedProduct != null,
        listener: (context, state) {
          if (state.selectedProduct != null) {
            Navigator.pushNamed(context, Routes.productDetails,
                arguments: state.selectedProduct);
          }
        },
        builder: (context, state) {
          if (state.baseState is BaseLoadingState) {
            return _buildDummyProductOfOccasion();
          }
          if (state.baseState is BaseHideLoadingState) {
            Navigator.of(context).pop();
          }
          if (state.baseState is BaseErrorState) {
            return Center(
              child: ErrorStateWidget(
                height: 50,
                width: 50,
                message: (state.baseState as BaseErrorState).errorMessage,
                onRetry: () => context.read<BestSellerCubit>().doIntent(GetDataAction()),
              ),
            );
          }
          if (state.baseState is BaseSuccessState) {
            final bestSellerResponse = (state.baseState as BaseSuccessState).data
                as SuccessResult<BestSellerResponseEntity>;
            final bestSellerList = bestSellerResponse.data.bestSeller;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: bestSellerList?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 260,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final bestSellerItem = bestSellerList![index];
                  return InkWell(
                    onTap: () {
                      context
                          .read<BestSellerCubit>()
                          .doIntent(ProductSelectedAction(bestSellerItem));
                    },
                    child: BlocProvider(
                      create: (context) => serviceLocator<CartCubit>(),
                      child: BlocConsumer<CartCubit, CartState>(
                        builder: (context, state) {
                          final cartCubit = context.read<CartCubit>();
                          return ProductCard.createProductCard(
                            bestSellerItem.imgCover,
                            bestSellerItem.title,
                            bestSellerItem.priceAfterDiscount,
                            bestSellerItem.price,
                            bestSellerItem.discount,
                            quantity: bestSellerItem.quantity,
                            onAddToCart: () {
                              if (_appCubit.getStateUser == StateUser.guest) {
                                AppDialogs.showLoginDialog(
                                  context,
                                  message: LocaleKeys.Error_YouHaveToLoginToUseThisFeature
                                      .tr(),
                                );
                              } else {
                                cartCubit.addProductToCart(
                                    bestSellerItem.id.toString(), 1);
                              }
                            },
                            productId: bestSellerItem.id.toString(),
                          );
                        },
                        listener: (BuildContext context, CartState state) {
                          if (state is CartSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.green,
                                content: Text(
                                  state.productCart.message.toString(),
                                  style: AppTheme.lightTheme.textTheme.labelSmall,
                                ),
                              ),
                            );
                          } else if (state is CartErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.red,
                                content: Text(
                                  LocaleKeys.Error_SoldOut.tr(),
                                  style: AppTheme.lightTheme.textTheme.labelSmall,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Placeholder();
        },
      ),
    );
  }

  Widget _buildDummyProductOfOccasion() {
    return Expanded(
      child: Skeletonizer(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 15,
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
}
