import 'package:flowery_app/features/home/presentation/view_model/best_seller/best_seller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_state/base_state.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../../product_details/presentation/models/product_details_model.dart';
import '../../../domain/entity/best_seller_response_entity.dart';
import '../../../domain/usecase/best_seller_use_case.dart';

@injectable
class BestSellerCubit extends Cubit<BestSellerState> {
  final BestSellerUseCase _bestSellerUseCase;

  BestSellerCubit(this._bestSellerUseCase)
      : super(BestSellerState(baseState: BaseInitialState()));

  void doIntent(BestSellerAction action) {
    switch (action) {
      case GetDataAction():
        _fetchBestSeller();
      case ProductSelectedAction():
        _mapBestSellerToProduct(action.item);
    }
  }

  Future<BestSellerResponseEntity?> _fetchBestSeller() async {
    emit(state.copyWith(baseState: BaseLoadingState()));
    final result = await _bestSellerUseCase.call();
    switch (result) {
      case SuccessResult<BestSellerResponseEntity>():
        {
          emit(state.copyWith(baseState: BaseHideLoadingState()));
          emit(state.copyWith(baseState: BaseSuccessState(data: result)));
        }
      case FailureResult<BestSellerResponseEntity>():
        {
          emit(
            state.copyWith(
              baseState: BaseErrorState(
                  errorMessage: result.exception.toString(), exception: result.exception),
            ),
          );
        }
    }
    return null;
  }

  void _mapBestSellerToProduct(BestSellerEntity item) {
    final mappedProduct = ProductDetailsModel(
      id: item.id.toString(),
      price: item.price,
      description: item.description,
      name: item.title,
      images: item.images,
      inStock: item.quantity != null ? true : false,
    );

    emit(state.copyWith(selectedProduct: mappedProduct));
  }
}
