import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:flowery_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flowery_app/features/home/presentation/view_model/cubit/home_state.dart';
import 'package:flowery_app/features/home/presentation/widget/custom_card.dart';
import 'package:flowery_app/features/home/presentation/widget/section_location.dart';
import 'package:flowery_app/features/home/presentation/widget/section_search.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return Center(child: CircularProgressIndicator());
            } else if (state.homeData is BaseErrorState) {
              final ans = state.homeData as BaseErrorState;
              return Center(child: Text(ans.errorMessage));
            } else if (state.homeData is BaseSuccessState) {
              final ans = state.homeData as BaseSuccessState<HomeEntity>;
              return ListView(
                children: [
                  SectionSearch(),
                  const SizedBox(height: 20),
                  SectionLocation(),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.Home_Categories.tr(),
                            style: theme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(LocaleKeys.Home_ViewAll.tr()))
                        ],
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CustomCacheNetworkImage(
                                            imageUrl: ans.data?.category[index]
                                                    .image ??
                                                ''),
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
                            }),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.Home_BestSeller.tr(),
                                style: theme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, Routes.bestSeller);
                                  },
                                  child: Text(LocaleKeys.Home_ViewAll.tr()))
                            ],
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
                                    image:
                                        ans.data!.bestSeller[index].imgCover!,
                                    price: ans.data!.bestSeller[index].price,
                                    title: ans.data!.bestSeller[index].title,
                                    type: TypeOfCard.Big);

                                BigCard(
                                    image:
                                        ans.data!.bestSeller[index].imgCover!,
                                    price: ans.data!.bestSeller[index].price,
                                    title: ans.data!.bestSeller[index].title);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.Home_Occasion.tr(),
                                style: theme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(LocaleKeys.Home_ViewAll.tr()))
                            ],
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
                                      type: TypeOfCard.Small);

                                  SmallCard(
                                      image: ans.data!.occasion[index].image!,
                                      title: ans.data!.occasion[index].name!);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 16);
                                },
                                itemCount: ans.data!.occasion.length),
                          )
                        ],
                      )
                    ],
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
}
