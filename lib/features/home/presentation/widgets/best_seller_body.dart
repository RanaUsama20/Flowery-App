import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/widgets/card.dart';
import 'package:flowery_app/features/home/presentation/view_model/cubit/best_seller/best_seller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_state/base_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';
import '../../domain/entity/best_seller/best_seller_response_entity.dart';
import '../view_model/cubit/best_seller/best_seller_state.dart';

class BestSellerBody extends StatefulWidget {
  const BestSellerBody({super.key});

  @override
  State<BestSellerBody> createState() => _BestSellerBodyState();
}

class _BestSellerBodyState extends State<BestSellerBody> {
  late BestSellerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = serviceLocator<BestSellerCubit>();
    cubit.doIntent(GetDataAction());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<BestSellerCubit, BestSellerState>(
          listenWhen: (previous, current) => current.selectedProduct != null,
          listener: (context, state) {
            if (state.selectedProduct != null) {
              print(
                  'besssssssst seller item : ${state.selectedProduct!.price}');
              Navigator.pushNamed(context, Routes.productDetails,
                  arguments: state.selectedProduct);
            }
          },
          builder: (context, state) {
            if (state.baseState is BaseLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.baseState is BaseHideLoadingState) {
              Navigator.of(context).pop();
            }
            if (state.baseState is BaseErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppDialogs.showFailureDialog(
                  context,
                  message: (state.baseState as BaseErrorState).errorMessage,
                );
              });
            }
            if (state.baseState is BaseSuccessState) {
              final bestSellerResponse = (state.baseState as BaseSuccessState)
                  .data as SuccessResult<BestSellerResponseEntity>;
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
                              bestSellerItem.imgCover!,
                              bestSellerItem.title!,
                              bestSellerItem.priceAfterDiscount!,
                              bestSellerItem.price!,
                              bestSellerItem.discount!,
                              onAddToCart: () {
                                cartCubit.addProductToCart(
                                    bestSellerItem.id.toString(), 1);
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
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall,
                                  ),
                                ),
                              );
                            } else if (state is CartErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.red,
                                  content: Text(
                                    LocaleKeys.Error_SoldOut.tr(),
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall,
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
          }),
    );

  }
}
