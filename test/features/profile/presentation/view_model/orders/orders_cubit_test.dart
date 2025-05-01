import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/domain/entity/orders/orders_entity.dart';
import 'package:flowery_app/features/profile/domain/usecase/get_orders_usecase.dart';
import 'package:flowery_app/features/profile/presentation/view_model/orders/orders_cubit.dart';
import 'package:flowery_app/features/profile/presentation/view_model/orders/orders_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_cubit_test.mocks.dart';

@GenerateMocks([GetOrdersUseCase])

void main() {
  late OrdersCubit ordersCubit;
  late GetOrdersUseCase getOrdersUseCase;
  OrdersResponseEntity? orders =  OrdersResponseEntity(
      orders: [
        OrdersEntity(
          id: '1' , user: '1',

        ),
        OrdersEntity(
          id: '2' , user: '2',

        )]

  );
  SuccessResult<OrdersResponseEntity?> ordersResult = SuccessResult(orders);
  provideDummy<SuccessResult<OrdersResponseEntity?>>(ordersResult);

  group('orders cubit test', (){
    //
    // List<OrdersEntity>? activeOrder =[
    //   OrdersEntity(
    //     id: '1' , user: '1'
    //   ),
    //   OrdersEntity(
    //       id: '2' , user: '2'
    //   ),
    // ];
    // List<OrdersEntity>? completedOrder =[
    //   OrdersEntity(
    //       id: '1' , user: '1'
    //   ),
    //   OrdersEntity(
    //       id: '2' , user: '2'
    //   ),
    // ];
    setUpAll((){
      getOrdersUseCase = MockGetOrdersUseCase();

      Result<OrdersResponseEntity?> ordersResult = SuccessResult(orders);
      provideDummy<Result<OrdersResponseEntity?>>(ordersResult);
      when(getOrdersUseCase.call()).thenAnswer((_) async => ordersResult );

    });

    setUp((){
      ordersCubit = OrdersCubit(getOrdersUseCase);

    });
      blocTest<OrdersCubit , OrdersState >("when call do intent it should load the user's orders list",
        build: () => ordersCubit,
        act: (cubit) {
        ordersCubit.doIntent(GetOrdersAction());
        },
          expect: () => [
            OrdersState(baseState: BaseLoadingState()),
            OrdersState(
              baseState: BaseSuccessState(data: ordersResult),
              activeOrders: [],
              completedOrders: [],
            ),
          ],
        verify: (_) {
          verify(() => getOrdersUseCase.call()).called(1);
        },
        // expect: () => [
        //   isA<OrdersState>().having((s) => s.baseState.runtimeType, 'baseState type', BaseLoadingState),
        //   isA<OrdersState>()
        //       .having((s) => s.baseState.runtimeType, 'baseState type', BaseSuccessState(data: SuccessResult(orders)))
        //       .having((s) => s.activeOrders, 'activeOrders', [])
        //       .having((s) => s.completedOrders, 'completedOrders', []),
        // ],


      );

  });

}