import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flowery_app/core/utils/widgets/error_widget.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:flowery_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flowery_app/features/home/presentation/view_model/cubit/home_state.dart';

import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/custom_card.dart';
import '../widgets/section_location.dart';
import '../widgets/section_search.dart';
import 'package:flowery_app/features/product_details/presentation/models/product_details_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = serviceLocator.get<HomeCubit>();
    _homeCubit.getHomeData();
  }

  Future<void> _onRefresh() async {
    await _homeCubit.getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: BlocBuilder<HomeCubit, HomeStates>(
          bloc: _homeCubit,
          builder: (context, state) {
            if (state.homeData is BaseLoadingState) {
              return _dummyScreen(theme);
            } else if (state.homeData is BaseErrorState) {
              return Center(
                child: ErrorStateWidget(
                  height: 50,
                  width: 50,
                  message: (state.homeData as BaseErrorState).errorMessage,
                  onRetry: () => _homeCubit.getHomeData(),
                ),
              );
            } else if (state.homeData is BaseSuccessState) {
              final ans = state.homeData as BaseSuccessState<HomeEntity>;
              return RefreshIndicator(
                color: AppColors.pink,
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SectionSearch(),
                      const SizedBox(height: 20),
                      SectionLocation(),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          _sectionTitle(
                            LocaleKeys.Home_Categories.tr(),
                                () {
                              Navigator.pushNamed(context, Routes.categories);
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              itemCount: ans.data!.category.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 16);
                              },
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.productDetails,
                                      arguments: ProductDetailsModel(
                                        id: ans.data!.category[index].id!,
                                        name: ans.data!.category[index].name!,
                                        description: 'Category Description', // Adjust as needed
                                        images: ans.data!.category[index].image != null
                                            ? [ans.data!.category[index].image!] // Wrap it in a list if it's not null
                                            : [],
                                        price: 0, // Adjust as needed
                                        inStock: true, // Adjust as needed
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: AppColors.lightPink,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CustomCacheNetworkImage(
                                              imageUrl: ans.data?.category[index].image ?? '',
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        ans.data!.category[index].name!,
                                        style: theme.labelMedium,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          _sectionTitle(
                            LocaleKeys.Home_BestSeller.tr(),
                                () {
                              Navigator.pushNamed(context, Routes.bestSeller);
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 16);
                              },
                              itemCount: ans.data!.bestSeller.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final product = ans.data!.bestSeller[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.productDetails,
                                      arguments: ProductDetailsModel(
                                        id: product.id!,
                                        name: product.title!,
                                        description: product.description ?? '',
                                        images: product.images ?? [],
                                        price: product.price!,
                                        inStock: product.quantity==0?false:true,
                                      ),
                                    );
                                  },
                                  child: CardOfItem.cardType(
                                    image: product.imgCover!,
                                    price: product.price,
                                    title: product.title,
                                    type: TypeOfCard.Big,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          _sectionTitle(
                            LocaleKeys.Home_Occasion.tr(),
                                () {
                              Navigator.pushNamed(context, Routes.occasion);
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final product = ans.data!.occasion[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.occasion,
                                      arguments: {
                                        'occasionId': product.id, // assuming this exists
                                        'occasionIndex': index, // or use index if occasionId not available
                                      },
                                    );
                                  },
                                  child: CardOfItem.cardType(
                                    image: product.image!,
                                    title: product.name,
                                    type: TypeOfCard.Small,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 16);
                              },
                              itemCount: ans.data!.occasion.length,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, void Function()? onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(LocaleKeys.Home_ViewAll.tr()),
        ),
      ],
    );
  }

  Widget _dummyScreen(TextTheme theme) {
    return Skeletonizer(
      child: Column(
        children: [
          SectionSearch(),
          const SizedBox(height: 20),
          SectionLocation(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _sectionTitle(
                  LocaleKeys.Home_Categories.tr(),
                      () {
                    Navigator.pushNamed(context, Routes.categories);
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 16);
                    },
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.lightPink,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Dummy Name",
                            style: theme.labelMedium,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                _sectionTitle(
                  LocaleKeys.Home_BestSeller.tr(),
                      () {
                    Navigator.pushNamed(context, Routes.bestSeller);
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 16);
                    },
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              color: AppColors.paleBlue,
                            ),
                            const SizedBox(height: 5),
                            Text("Dummy Name",
                                style: theme.bodyLarge,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 3),
                            Text('223 EGP', style: theme.labelMedium)
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                _sectionTitle(
                  LocaleKeys.Home_Occasion.tr(),
                      () {
                    Navigator.pushNamed(context, Routes.occasion);
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              color: AppColors.paleBlue,
                            ),
                            const SizedBox(height: 5),
                            Text("Dummy Occasion Name",
                                style: theme.bodyLarge,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 16);
                    },
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
