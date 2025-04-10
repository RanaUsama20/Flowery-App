
import 'package:equatable/equatable.dart';
import '../../../../../../core/base_state/base_state.dart';
import '../../../../domain/entity/best_seller/best_seller_entity.dart';

class BestSellerState extends Equatable {
  final BaseState? baseState;
  // final ProductDetailsModel? selectedProduct;


  const BestSellerState({
    this.baseState,
    // this.selectedProduct,

  });

  BestSellerState copyWith({
    BaseState? baseState,
    // ProductDetailsModel? selectedProduct,

  }) {
    return BestSellerState(
      baseState: baseState ?? this.baseState,
      // selectedProduct: selectedProduct ?? this.selectedProduct,

    );
  }

  @override
  // List<Object?> get props => [baseState,selectedProduct];
  List<Object?> get props => [baseState];

}

sealed class BestSellerAction {}


final class GetDataAction extends BestSellerAction {}

final class ProductSelectedAction extends BestSellerAction {
  final BestSellerEntity item;
  ProductSelectedAction(this.item);
}

