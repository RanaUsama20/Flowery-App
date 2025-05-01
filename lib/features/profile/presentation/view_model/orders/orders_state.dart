
import 'package:equatable/equatable.dart';
import '../../../../../../core/base_state/base_state.dart';
import '../../../domain/entity/orders/orders_entity.dart';

class OrdersState extends Equatable {
 final BaseState? baseState;
 final List<OrdersEntity>? activeOrders;
 final List<OrdersEntity>? completedOrders;


 const OrdersState({
   this.baseState,
  this.activeOrders,
  this.completedOrders

 });

 OrdersState copyWith({
   BaseState? baseState,
  List<OrdersEntity>? activeOrders,
  List<OrdersEntity>? completedOrders

 }) {
  return OrdersState(
   baseState: baseState ?? this.baseState,
   activeOrders: activeOrders ?? this.activeOrders,
   completedOrders: completedOrders ?? this.completedOrders,


  );
 }

 @override
 List<Object?> get props => [baseState,activeOrders,completedOrders];

}

sealed class OrdersAction {}


final class GetOrdersAction extends OrdersAction {}


