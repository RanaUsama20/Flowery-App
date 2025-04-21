import 'package:flowery_app/features/checkout/data/api/checkout_retrofit_client.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/remote/api_manager.dart';
import 'checkout_remote_data_source.dart';

@Injectable(as: CheckoutRemoteDataSource)
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final CheckoutRetrofitClient _checkoutRetrofitClient;
  final ApiManager _apiManager;

  CheckoutRemoteDataSourceImpl(this._checkoutRetrofitClient, this._apiManager);




}
