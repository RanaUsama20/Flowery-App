import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/common/screen/empty_screen.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/dialogs/app_toasts.dart';
import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';
import 'package:flowery_app/features/cart/presentation/widget/cart_widget.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../view_model/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CartCubit, CartState>(
          buildWhen: (previous, current) =>
              previous.getProductStatus != current.getProductStatus ||
              previous.cartModelEntity != current.cartModelEntity ||
              previous.updateProductStatus != current.updateProductStatus,
          listener: (context, state) {
            if (state.deleteProductIsFailure ||
                state.getProductIsFailure ||
                state.updateProductIsFailure ||
                state.deleteProductIsFailure) {
              AppToast.showToast(
                context: context,
                title: LocaleKeys.Error.tr(),
                description: state.errorFromGetProduct,
                type: ToastificationType.error,
              );
            }
          },
          builder: (context, state) {
            if (state.getProductIsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  _buildHeader(state.cartModelEntity.numOfCartItems.toInt()),
                  state.cartModelEntity.cart.cartItems.isNotEmpty
                      ? _buildCartList(state.cartModelEntity.cart.cartItems)
                      : EmptyScreen(),
                  const SizedBox(height: 30),
                  // _buildCartSummary(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(int numOfCartItems) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                LocaleKeys.Home_Cart.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 5),
              Text(
                "($numOfCartItems  ${LocaleKeys.Home_Items.tr()}) ",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.gray,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: AppColors.gray),
        ],
      ),
    );
  }

  Widget _buildCartList(List<CartItemsEntity> products) {
    final listKey = GlobalKey<AnimatedListState>();
    return Expanded(
      child: AnimatedList(
        key: listKey,
        initialItemCount: products.length,
        itemBuilder: (context, index, animation) => CartItemWidget(
          packageProduct: products[index],
          animation: animation,
          onClickProduct: () {},
          onTapDelete: () async {
            final removedItem = products[index];
            final removedProductId = removedItem.product.id;
            products.removeAt(index);
            listKey.currentState?.removeItem(
              index,
              (context, animation) => CartItemWidget(
                packageProduct: removedItem,
                animation: animation,
                onClickProduct: () {},
                onTapDelete: () {},
              ),
              duration: const Duration(milliseconds: 600),
            );
            await context.read<CartCubit>().deleteProduct(removedProductId);
          },
        ),
      ),
    );
  }
}
