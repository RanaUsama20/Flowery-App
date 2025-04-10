
class GetAllCategoriesEntity {
  List<CategoriesEntity> categories=[];
  GetAllCategoriesEntity({required this.categories});
}

 class CategoriesEntity {
   String id;
   String name;
   String slug;
   String image;
   String createdAt;
   String updatedAt;
   int productsCount;
   CategoriesEntity({required this.id,required this.name,required this.slug,required this.image,required this.createdAt,required this.updatedAt,required this.productsCount});
 }