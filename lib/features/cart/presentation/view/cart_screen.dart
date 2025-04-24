import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/cart/presentation/widget/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app/app_cubit/app_cubit_cubit.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../core/enum/state_user.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../home/presentation/widgets/section_location.dart';
import '../view_model/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartCubit cartCubit = serviceLocator<CartCubit>();
  late AppCubit _appCubit;

  @override
  void initState() {
    super.initState();
    _appCubit = serviceLocator<AppCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_appCubit.getStateUser ==
          StateUser.guest) {
        AppDialogs.showLoginDialog(
            context,
            message: LocaleKeys
                .Error_YouHaveToLoginToUseThisFeature
                .tr());
      } else {
        Future.microtask(() => context.read<CartCubit>().getProductToCart());

      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartSuccessState) {
            final items = state.productCart.cart?.cartItems ?? [];

            if (items.isEmpty) {
              return Center(
                  child: Text(LocaleKeys.Home_EmptyCart.tr(),
                      style: AppTheme.lightTheme.textTheme.labelLarge));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, Routes.appSection);
                            },
                            icon: Icon(Icons.arrow_back_ios_new_outlined),
                          ),
                          SizedBox(width: 10),
                          Text(LocaleKeys.Home_Cart.tr(),
                              style: AppTheme.lightTheme.textTheme.titleLarge),
                          SizedBox(width: 5),
                          Text(
                              "(${state.productCart.numOfCartItems.toString() + LocaleKeys.Home_Items.tr()})",
                              style: AppTheme.lightTheme.textTheme.titleLarge
                                  ?.copyWith(
                                  color: AppColors.gray,
                                  fontWeight: FontWeight.w400)),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              context.read<CartCubit>().deleteProductToCart("");
                            },
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              size: 28,
                            ),
                            color: AppColors.red,
                          )
                        ]),
                        Row(
                          children: [
                            SectionLocation(),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.expand_more_sharp,
                                size: 26,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var product = items[index].product;
                        // final mappedProduct = ProductDetailsModel(
                        //   price: product!.price!.toInt(),
                        //   description: product.description!,
                        //   name: product.title!,
                        //   images: product.images!,
                        //   inStock: product.quantity != null
                        //       ? true
                        //       : false,
                        // );

                        return InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, Routes.productDetails,
                            //     arguments: mappedProduct);
                          },
                          child: CartItemWidget(
                            imageUrl: product?.imgCover ?? '',
                            title: product?.title ?? '',
                            description: product?.description ?? '',
                            price: product?.price ?? 0,
                            quantity: items[index].quantity ?? 0,
                            onIncrement: () {
                              final cubit = context.read<CartCubit>();
                              final currentQuantity =
                                  items[index].quantity ?? 1;
                              cubit.updateProductQuantity(
                                  product!.id!, currentQuantity + 1);
                            },
                            onDecrement: () {
                              final cubit = context.read<CartCubit>();
                              final currentQuantity =
                                  items[index].quantity ?? 1;
                              if (currentQuantity > 1) {
                                cubit.updateProductQuantity(
                                    product!.id!, currentQuantity - 1);
                              }
                            },
                            onRemove: () {
                              final cubit = context.read<CartCubit>();
                              final cartItemId = product!.id;
                              cubit.deleteProductToCart(cartItemId!);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.Home_TotalPrice.tr()}  : ",
                              style: AppTheme.lightTheme.textTheme.titleLarge
                                  ?.copyWith(
                                  fontSize: 16, color: AppColors.gray),
                            ),
                            Spacer(),
                            Text("${state.productCart.cart?.totalPrice}",
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                    fontSize: 16, color: AppColors.gray)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.Home_Discount.tr()} : ",
                              style: AppTheme.lightTheme.textTheme.titleLarge
                                  ?.copyWith(
                                  fontSize: 16, color: AppColors.gray),
                            ),
                            Spacer(),
                            Text("${state.productCart.cart?.discount} %",
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                    fontSize: 16, color: AppColors.gray)),
                          ],
                        ),
                        Divider(
                          color: AppColors.black[AppColors.colorCode40]?.withOpacity(0.5),
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.Home_PriceAfterDiscount.tr()}  : ",
                              style: AppTheme.lightTheme.textTheme.titleMedium,
                            ),
                            Spacer(),
                            Text(
                              "${state.productCart.cart?.totalPriceAfterDiscount}",
                              style: AppTheme.lightTheme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                            style: AppTheme.lightTheme.elevatedButtonTheme.style
                                ?.copyWith(
                              minimumSize: MaterialStatePropertyAll(
                                  Size(double.infinity, 50)),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(LocaleKeys.Home_CheckOut.tr(),
                                style: AppTheme.lightTheme.textTheme.titleSmall
                                    ?.copyWith(color: AppColors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CartErrorState) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


