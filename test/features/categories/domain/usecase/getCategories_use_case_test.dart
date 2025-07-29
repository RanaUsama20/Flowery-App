import 'package:flowery_app/features/categories/domain/entity/get_all_categories_entity.dart';
import 'package:flowery_app/features/categories/domain/entity/get_products_by_id_entity.dart';
import 'package:flowery_app/features/categories/domain/repository/get_categories_repository.dart';
import 'package:flowery_app/features/categories/domain/usecase/get_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'getCategories_use_case_test.mocks.dart';

@GenerateMocks([CategoriesRepository])
void main() {
  late MockGetCategoriesRepository mockRepository;
  late GetCategoriesUseCase useCase;

  setUp(() {
    mockRepository = MockGetCategoriesRepository();
    useCase = GetCategoriesUseCase(mockRepository);
  });

  test('should return list of CategoriesEntity from repository', () async {
    final categories = [
      CategoriesEntity(
          id: '1',
          name: 'Test',
          slug: '',
          image: '',
          createdAt: '',
          updatedAt: '',
          productsCount: 0)
    ];
    final response = GetAllCategoriesEntity(categories: categories);
    when(mockRepository.getAllCategories()).thenAnswer((_) async => response);

    final result = await useCase.getAllCategories();

    expect(result, equals(categories));
    verify(mockRepository.getAllCategories()).called(1);
  });

  test('should return list of ProductsEntity from repository by categoryId', () async {
    const categoryId = '1';
    final products = [
      ProductsOfCategoryEntity(
        id: '101',
      )
    ];
    final response = ProductsOfCategoryResponseEntity(products: products);
    when(mockRepository.getProductsById(categoryId)).thenAnswer((_) async => response);

    final result = await useCase.getProductsById(categoryId);

    expect(result, equals(products));
    verify(mockRepository.getProductsById(categoryId)).called(1);
  });
}
