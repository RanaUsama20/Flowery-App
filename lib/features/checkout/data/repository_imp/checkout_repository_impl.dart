import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/checkout_repository.dart';
import '../data_source/remote/checkout_remote_data_source.dart';


@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource _checkoutRemoteDataSource;
  final ApiManager _apiManager;
  CheckoutRepositoryImpl(this._apiManager, this._checkoutRemoteDataSource);


}






