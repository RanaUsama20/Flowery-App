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
  final AppCubit appCubit = serviceLocator<AppCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (appCubit.getStateUser == StateUser.guest) {
        AppDialogs.showLoginDialog(
          context,
          message: LocaleKeys.Error_YouHaveToLoginToUseThisFeature.tr(),
        );
      } else {
        context.read<CartCubit>().getProductToCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartErrorState) {
            AppDialogs.showFailureDialog(
              context,
              message: state.error.message,
              nextAction: () =>
                  Navigator.pushReplacementNamed(context, Routes.appSection),
            );
          }
        },
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartSuccessState) {
            final items = state.productCart.cart?.cartItems ?? [];

            if (items.isEmpty) {
              return Center(
                child: Text(
                  LocaleKeys.Home_EmptyCart.tr(),
                  style: AppTheme.lightTheme.textTheme.labelLarge,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  _buildHeader(context, state),
                  _buildCartList(items),
                  const SizedBox(height: 30),
                  _buildCartSummary(state),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CartSuccessState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.appSection);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
              const SizedBox(width: 10),
              Text(
                LocaleKeys.Home_Cart.tr(),
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
              const SizedBox(width: 5),
              Text(
                "(${state.productCart.numOfCartItems}${LocaleKeys.Home_Items.tr()})",
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppColors.gray,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.read<CartCubit>().deleteProductToCart("");
                },
                icon: const Icon(Icons.delete_forever_outlined, size: 28),
                color: AppColors.red,
              ),
            ],
          ),
          Row(
            children: [
              // const SectionLocation(address:context.read<CartCubit>().,),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.expand_more_sharp, size: 26),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(List items) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final product = items[index].product;
          final quantity = items[index].quantity ?? 1;

          return InkWell(
            onTap: () {},
            child: CartItemWidget(
              imageUrl: product?.imgCover ?? '',
              title: product?.title ?? '',
              description: product?.description ?? '',
              price: product?.price ?? 0,
              quantity: quantity,
              onIncrement: () {
                context
                    .read<CartCubit>()
                    .updateProductQuantity(product!.id!, quantity + 1);
              },
              onDecrement: () {
                if (quantity > 1) {
                  context
                      .read<CartCubit>()
                      .updateProductQuantity(product!.id!, quantity - 1);
                }
              },
              onRemove: () {
                context.read<CartCubit>().deleteProductToCart(product!.id!);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartSummary(CartSuccessState state) {
    final cart = state.productCart.cart!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildSummaryRow(LocaleKeys.Home_TotalPrice.tr(), "${cart.totalPrice}"),
          const SizedBox(height: 10),
          _buildSummaryRow(LocaleKeys.Home_Discount.tr(), "${cart.discount} %"),
          Divider(
            color: AppColors.black[AppColors.colorCode40]?.withOpacity(0.5),
            thickness: 1,
          ),
          _buildSummaryRow(
              LocaleKeys.Home_PriceAfterDiscount.tr(), "${cart.totalPriceAfterDiscount}"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 50)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Routes.checkout, arguments: cart.totalPriceAfterDiscount);
              },
              child: Text(
                LocaleKeys.Home_CheckOut.tr(),
                style: AppTheme.lightTheme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label : ",
          style: AppTheme.lightTheme.textTheme.titleLarge
              ?.copyWith(fontSize: 16, color: AppColors.gray),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.titleLarge
              ?.copyWith(fontSize: 16, color: AppColors.gray),
        ),
      ],
    );
  }
}
