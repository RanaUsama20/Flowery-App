import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/common/screen/empty_screen.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';
import 'package:flowery_app/features/cart/presentation/widget/cart_widget.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartCubit>().getProductToCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          previous.getProductStatus != current.getProductStatus,
      builder: (context, state) {
        if (state.getProductIsFailure) {
          return EmptyScreen();
        }
        if (state.getProductIsSuccess) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  TopSectionCart(numOfCartItems: state.cartModelEntity.numOfCartItems),
                  ListCartItems(products: state.cartModelEntity.cart.cartItems),
                  SizedBox(height: 200),
                ],
              ),
            ),
            bottomSheet: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) =>
                  previous.updateProductStatus != current.updateProductStatus ||
                  previous.deleteProductStatus != current.deleteProductStatus,
              builder: (context, state) {
                if (state.cartModelEntity.cart.cartItems.isNotEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(color: AppColors.gray),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sub Total',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppColors.gray, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${state.cartModelEntity.cart.totalPrice.toString()} ${LocaleKeys.Home_EGP.tr()}',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppColors.gray, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Fee',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '20 ${LocaleKeys.Home_EGP.tr()}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      Divider(color: AppColors.gray),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.black, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${state.cartModelEntity.cart.totalPrice + 20} ${LocaleKeys.Home_EGP.tr()}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.black, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                        child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                minimumSize:
                                    MaterialStatePropertyAll(Size.fromHeight(10)),
                              ),
                          onPressed: () {},
                          child: Text(LocaleKeys.Home_Checkout.tr()),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ListCartItems extends StatefulWidget {
  const ListCartItems({super.key, required this.products});
  final List<CartItemsEntity> products;

  @override
  State<ListCartItems> createState() => _ListCartItemsState();
}

class _ListCartItemsState extends State<ListCartItems> {
  final listKey = GlobalKey<AnimatedListState>();
  late List<CartItemsEntity> productsItems;
  @override
  void initState() {
    super.initState();
    productsItems = List.from(widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return productsItems.isEmpty
        ? EmptyScreen()
        : Expanded(
            child: AnimatedList(
              key: listKey,
              initialItemCount: productsItems.length,
              itemBuilder: (context, index, animation) => CartItemWidget(
                animation: animation,
                packageProduct: productsItems[index],
                index: index,
                onClickProduct: () {},
                onTapDelete: () => removeItem(index),
              ),
            ),
          );
  }

  void removeItem(int index) async {
    final removedItem = productsItems[index];
    final removedProductId = removedItem.product.id;
    productsItems.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (context, animation) => CartItemWidget(
        packageProduct: removedItem,
        animation: animation,
        index: index,
        onClickProduct: () {},
        onTapDelete: () {},
      ),
      duration: const Duration(milliseconds: 600),
    );
    if (productsItems.isEmpty) {
      context.read<CartCubit>().getProductToCart();
    }
    await context.read<CartCubit>().deleteProduct(removedProductId);
  }
}

class TopSectionCart extends StatelessWidget {
  const TopSectionCart({super.key, required this.numOfCartItems});
  final num numOfCartItems;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(width: 5),
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
          const SizedBox(height: 5),
          Divider(color: AppColors.gray),
        ],
      ),
    );
  }
}
