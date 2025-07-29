import 'package:flowery_app/features/categories/data/data_source/getCategories_data_source.dart';
import 'package:flowery_app/features/categories/data/repository_imp/getCategories_repository_impl.dart';
import 'package:flowery_app/features/categories/domain/entity/get_all_categories_entity.dart';
import 'package:flowery_app/features/categories/domain/entity/get_products_by_id_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'getCategories_repository_impl_test.mocks.dart';

@GenerateMocks([GetAllCategoriesDataSource])
void main() {
  late MockGetAllCategoriesDataSource mockDataSource;
  late GetCategoriesRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockGetAllCategoriesDataSource();
    repository = GetCategoriesRepositoryImpl(mockDataSource);
  });

  test('should return GetAllCategoriesEntity from dataSource', () async {
    final mockEntity = GetAllCategoriesEntity(categories: []);
    when(mockDataSource.getAllCategories()).thenAnswer((_) async => mockEntity);

    final result = await repository.getAllCategories();

    expect(result, equals(mockEntity));
    verify(mockDataSource.getAllCategories()).called(1);
  });

  test('should return ProductsModelEntity from dataSource by categoryId', () async {
    final mockEntity = ProductsOfCategoryResponseEntity();
    const categoryId = '123';

    when(mockDataSource.getProductsById(categoryId)).thenAnswer((_) async => mockEntity);

    final result = await repository.getProductsById(categoryId);

    expect(result, equals(mockEntity));
    verify(mockDataSource.getProductsById(categoryId)).called(1);
  });
}
