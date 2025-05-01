import 'package:flowery_app/core/constants/app_values.dart';
import 'package:flowery_app/features/profile/domain/usecase/get_orders_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/base_state/base_state.dart';
import '../../../../../../core/network/common/api_result.dart';
import '../../../domain/entity/orders/orders_entity.dart';
import 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;

  OrdersCubit(this._getOrdersUseCase)
      : super(OrdersState(baseState: BaseInitialState()));

  void doIntent(OrdersAction action) {
    switch (action) {
      case GetOrdersAction():
        _getOrders();
    }
  }

  Future<OrdersResponseEntity?> _getOrders() async {
    emit(state.copyWith(baseState: BaseLoadingState()));
    final result = await _getOrdersUseCase.call();

    switch (result) {
      case SuccessResult<OrdersResponseEntity?>():
        {
          final orders = result.data?.orders ?? [];
          final active = orders.where((o) {
            final status = o.state?.toLowerCase();
            return status == AppValues.inProgressState || status == AppValues.pendingState;
          }).toList();
          final completed = orders.where((o) {
            final status = o.state?.toLowerCase();
            return status == AppValues.completedState || status == AppValues.canceledState;
          }).toList();

          emit(state.copyWith(
            baseState: BaseSuccessState(data: result),
            activeOrders: active,
            completedOrders: completed,
          ));
        }
      case FailureResult<OrdersResponseEntity?>():
        {
          emit(state.copyWith(
            baseState: BaseErrorState(
              errorMessage: result.exception.toString(),
              exception: result.exception,
            ),
          ));
        }
    }
    return null;
  }
}
