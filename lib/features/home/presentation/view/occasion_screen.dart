import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart';
import 'package:flowery_app/core/common/screen/empty_screen.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/common/widgets/product_card_app_widget.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/home/presentation/view_model/occasions/occasions_cubit.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/routes/routes.dart';
import '../../../product_details/presentation/models/product_details_model.dart';

class OccasionScreen extends StatefulWidget {
  const OccasionScreen({
    super.key,
  });

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> with TickerProviderStateMixin {
  // late TabController _tabController;
  late AppCubit _appCubit;
  @override
  void initState() {
    super.initState();
    _appCubit = serviceLocator.get<AppCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        leadingWidth: 25,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.hp(1.7)),
            Text(LocaleKeys.Home_Occasion.tr()),
            SizedBox(height: context.hp(0.2)),
            Text(
              LocaleKeys.Home_BestSellerSubTitle.tr(),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.white[AppColors.colorCode90],
                  ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wp(4)),
        child: BlocProvider<OccasionsCubit>(
          create: (context) => serviceLocator.get<OccasionsCubit>()..getTabOccasions(),
          child: BlocBuilder<OccasionsCubit, OccasionsState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: context.hp(2)),
                  state.isOccasionsLoading
                      ? _buildDummyTabBar()
                      : _buildTabBar(
                          state.occasions.map((e) => Tab(text: e.name)).toList(),
                          (index) {
                            context
                                .read<OccasionsCubit>()
                                .getProductsByOccasion(state.occasions[index].id);
                          },
                        ),
                  SizedBox(height: context.hp(2)),
                  state.isProductsLoading
                      ? _buildDummyProductOfOccasion()
                      : state.products.isNotEmpty
                          ? _buildProducts(state.products)
                          : EmptyScreen(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(List<Tab> tabs, Function(int index) callBack) {
    return DefaultTabController(
      length: tabs.length,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        onTap: (value) => callBack(value),
        isScrollable: true,
        tabs: tabs,
      ),
    );
  }

  Widget _buildProducts(List<ProductItemEntity> products) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 260,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.productDetails,
                arguments: ProductDetailsModel(
                  id: products[index].id.toString(),
                  price: products[index].price.toInt(),
                  description: products[index].description,
                  name: products[index].title,
                  images: products[index].images,
                  inStock: (products[index].quantity) > 0,
                ),
              );
            },
            child: ProductCardAppWidget(
              imageProduct: products[index].imgCover,
              title: products[index].title,
              price: products[index].price.toInt(),
              oldPrice: products[index].priceAfterDiscount.toInt(),
              discount: products[index].discount.toInt(),
              productId: products[index].id.toString(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDummyProductOfOccasion() {
    return Expanded(
      child: Skeletonizer(
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 260,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) => ProductCardAppWidget(
            imageProduct: imageDummy,
            title: "Hello User",
            discount: 32,
            oldPrice: 35,
            price: 30,
            productId: '',
          ),
        ),
      ),
    );
  }

  Widget _buildDummyTabBar() {
    return Skeletonizer(
      enabled: true,
      child: DefaultTabController(
        length: 10,
        child: TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(text: 'Wedding'),
            Tab(text: 'Graduation'),
            Tab(text: 'Birthday'),
            Tab(text: 'Katb Ketab'),
            Tab(text: 'Engagement'),
            Tab(text: 'Thank you'),
            Tab(text: 'Get well'),
            Tab(text: 'Wedding'),
            Tab(text: 'Engagement'),
            Tab(text: 'Birthday'),
          ],
        ),
      ),
    );
  }
}

//? dummy image
const String imageDummy =
    "https://flower.elevateegy.com/uploads/fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png";
