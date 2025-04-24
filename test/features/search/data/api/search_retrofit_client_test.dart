// import 'package:dio/dio.dart';
// import 'package:flowery_app/core/network/remote/api_constants.dart';
// import 'package:flowery_app/features/home/data/model/response/occasions/prodect_response_dto.dart';
// import 'package:flowery_app/features/search/data/api/search_retrofit_client.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'search_retrofit_client_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<Dio>(), MockSpec<BaseOptions>()])
// void main() {
//   group('SearchRetrofitClient', () {
//     late MockDio mockDio;
//     late SearchRetrofitClient client;

//     setUp(() {
//       mockDio = MockDio();
//       when(mockDio.options).thenReturn(MockBaseOptions());
//       client = SearchRetrofitClient(mockDio);
//     });
//     const query = 'testQuery';
//     final successResponse = ProductResponseDto(message: 'success');

//     test('searchProduct returns ProductResponseDto on success', () async {
//       final responseData = {'message': 'success'};
//       final httpResponse = Response(
//         data: responseData,
//         statusCode: 200,
//         requestOptions: RequestOptions(),
//       );

//       when(mockDio.get(any)).thenAnswer((_) async => httpResponse);

//       final result = await client.searchProduct(query);

//       // expect(result.message, successResponse.message);
//       // verify(mockDio.get(
//       //   'products/search',
//       //   queryParameters: {'keyword': query},
//       // )).called(1);
//     });
//   });
// }
