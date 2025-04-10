import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:flowery_app/features/home/presentation/view/occasion_screen.dart';
import 'package:flowery_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flowery_app/features/home/presentation/view_model/cubit/home_state.dart';

import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/custom_card.dart';
import '../widgets/section_location.dart';
import '../widgets/section_search.dart';

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
              final ans = state.homeData as BaseErrorState;
              return Center(child: Text(ans.errorMessage));
            } else if (state.homeData is BaseSuccessState) {
              final ans = state.homeData as BaseSuccessState<HomeEntity>;
              return Column(
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
                            itemCount: ans.data!.category.length,
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
                                    child: Center(
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CustomCacheNetworkImage(
                                          imageUrl: ans.data?.category[index].image ?? '',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    ans.data!.category[index].name!,
                                    style: theme.labelMedium,
                                  )
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
                            itemCount: ans.data!.bestSeller.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CardOfItem.cardType(
                                image: ans.data!.bestSeller[index].imgCover!,
                                price: ans.data!.bestSeller[index].price,
                                title: ans.data!.bestSeller[index].title,
                                type: TypeOfCard.Big,
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
                              return CardOfItem.cardType(
                                image: ans.data!.occasion[index].image!,
                                title: ans.data!.occasion[index].name,
                                type: TypeOfCard.Small,
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
                  )
                ],
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
        )
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
                          )
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
                                style: theme.bodyLarge, overflow: TextOverflow.ellipsis),
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
                            Text("Dummy Name",
                                style: theme.bodyLarge, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 3),
                            Text('223 EGP', style: theme.labelMedium)
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
          )
        ],
      ),
    );
  }
}
