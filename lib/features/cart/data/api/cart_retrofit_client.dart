import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../model/cart_model.dart';

part 'cart_retrofit_client.g.dart';

@lazySingleton
@RestApi(
  baseUrl: ApiConstants.baseUrl,
)
abstract class CartRetrofitClient {
  @factoryMethod
  factory CartRetrofitClient(Dio dio) = _CartRetrofitClient;
  @GET(ApiConstants.cart)
  Future<CartResponseModelDto> getProductToCart(
    @Header("Authorization") String token,
  );

  @POST(ApiConstants.addToCart)
  Future<CartResponseModelDto> addProductToCart(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> body,
  );

  @PUT("${ApiConstants.cart}{id}")
  Future<CartResponseModelDto> updateProductQuantity(
    @Header("Authorization") String token,
    @Path("id") String productId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("${ApiConstants.deleteCart}{id}")
  Future<CartResponseModelDto> deleteProductToCart(
    @Header("Authorization") String token,
    @Path("id") String cartItemId,
  );
}
