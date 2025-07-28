import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/status.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/home/domain/usecase/occasions_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/product_occasion_use_case.dart';

part 'occasions_state.dart';

@injectable
class OccasionsCubit extends Cubit<OccasionsState> {
  OccasionsUseCase occasionsUseCase;
  ProductOccasionUseCase productOccasionUseCase;
  OccasionsCubit(this.occasionsUseCase, this.productOccasionUseCase)
      : super(OccasionsState());

  Future<void> getTabOccasions() async {
    emit(state.copyWith(occasionsStatus: Status.loading, productsStatus: Status.loading));
    final result = await occasionsUseCase.call();
    switch (result) {
      case SuccessResult<OccasionsResponseEntity>():
        await getProductsByOccasion(result.data.occasions[0].id);
        emit(state.copyWith(
            occasionsStatus: Status.success, occasionsList: result.data.occasions));

      case FailureResult<OccasionsResponseEntity>():
        emit(state.copyWith(
            occasionsStatus: Status.failure, occasionError: result.exception.toString()));
    }
  }

  Future<void> getProductsByOccasion(String occasionId) async {
    emit(state.copyWith(productsStatus: Status.loading));
    final result = await productOccasionUseCase.call(occasionId);
    switch (result) {
      case SuccessResult<ProductEntity>():
        log(result.data.products.length.toString());
        emit(state.copyWith(
            productsStatus: Status.success, productsList: result.data.products));
      case FailureResult<ProductEntity>():
        emit(state.copyWith(
            productsStatus: Status.failure, productError: result.exception.toString()));
    }
  }
}
