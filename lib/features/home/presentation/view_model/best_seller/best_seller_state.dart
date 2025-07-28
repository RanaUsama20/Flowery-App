import 'package:equatable/equatable.dart';
import 'package:flowery_app/features/home/domain/entity/best_seller_response_entity.dart';
import '../../../../../core/base_state/base_state.dart';
import '../../../../product_details/presentation/models/product_details_model.dart';

class BestSellerState extends Equatable {
  final BaseState? baseState;
  final ProductDetailsModel? selectedProduct;

  const BestSellerState({
    this.baseState,
    this.selectedProduct,
  });

  BestSellerState copyWith({
    BaseState? baseState,
    ProductDetailsModel? selectedProduct,
  }) {
    return BestSellerState(
      baseState: baseState ?? this.baseState,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }

  @override
  List<Object?> get props => [baseState, selectedProduct];
}

sealed class BestSellerAction {}

final class GetDataAction extends BestSellerAction {}

final class ProductSelectedAction extends BestSellerAction {
  final BestSellerEntity item;
  ProductSelectedAction(this.item);
}
