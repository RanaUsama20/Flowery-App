import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/data/data_source/remote/home_remote_data_source.dart';
import 'package:flowery_app/features/home/data/model/response/best_seller_response_model.dart';
import 'package:flowery_app/features/home/domain/entity/best_seller/best_seller_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/best_seller/best_seller_response_entity.dart';
import '../../domain/repository/home_repository.dart';


@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  HomeRepositoryImpl(this._homeRemoteDataSource);
  @override
  Future<Result<BestSellerResponseEntity>> getBestSeller() async {
    final result = await _homeRemoteDataSource.getBestSeller();

    if (result is SuccessResult<BestSellerResponseDto>) {
      return SuccessResult(result.data.toDomain());
    } else if (result is FailureResult<BestSellerResponseDto>) {
      return FailureResult(result.exception);
    }
    return FailureResult(Exception("Unknown error occurred"));

  }
  }




