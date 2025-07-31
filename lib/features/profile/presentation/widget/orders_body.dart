import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_state/base_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/loading_widget.dart';
import '../../../../core/common/widgets/error_widget.dart';
import '../view_model/orders/orders_cubit.dart';
import '../view_model/orders/orders_state.dart';
import 'build_orders_list.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({super.key});

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  late OrdersCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = serviceLocator<OrdersCubit>();
    cubit.doIntent(GetOrdersAction());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.baseState is BaseLoadingState) {
            return const Center(child: LoadingWidget());
          }

          if (state.baseState is BaseErrorState) {
            return Center(
              child: ErrorStateWidget(
                height: 50,
                width: 50,
                message: (state.baseState as BaseErrorState).errorMessage,
                onRetry: () => context.read<OrdersCubit>().doIntent(GetOrdersAction()),
              ),
            );
          }

          final activeOrders = state.activeOrders;
          final completedOrders = state.completedOrders;

          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabAlignment: TabAlignment.fill,
                  isScrollable: false,
                  tabs: [
                    Tab(text: LocaleKeys.profile_Active.tr()),
                    Tab(text: LocaleKeys.profile_Completed.tr()),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      BuildOrdersList(orders: activeOrders, flag: true),
                      BuildOrdersList(orders: completedOrders, flag: false),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
