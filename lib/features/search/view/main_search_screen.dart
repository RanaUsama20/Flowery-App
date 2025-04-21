// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/enum/search_type.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/features/search/view_model/search_cubit.dart';
import 'package:flowery_app/features/search/widget/search_init_section.dart';
import 'package:flowery_app/features/search/widget/search_no_result_section.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchCubit cubit = SearchCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchFieldWidget(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
          ),
          onPressed: () => null,
        ),
        leadingWidth: 35,
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        bloc: cubit,
        builder: (context, state) {
          switch (state.searchType) {
            case SearchType.start:
              return SearchInitSection();
            case SearchType.empty:
              return SearchNoResultSection();
            case SearchType.result:
              return _resultsSearches();
            case SearchType.onClick:
              return _ListLatestSearches(state.listLatestSearches);
            case SearchType.onType:
              return _resultsWritingSearches(state.listSearchWriteResults);
          }
        },
      ),
    );
  }

  //* search field
  Widget _searchFieldWidget() {
    bool isTapped = false;
    return TextField(
      onChanged: (val) {
        if (val != "") {
          cubit.getListResultsWritingSearches(val);
        } else {
          cubit.getListLatestSearches();
        }
      },
      onTap: () async {
        if (!isTapped) {
          isTapped = true;
          await cubit.getListLatestSearches();
        }
      },
      onEditingComplete: () {
        log("onEditingComplete");
      },
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        fillColor: AppColors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white[AppColors.colorCode80]!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white[AppColors.colorCode80]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.all(10),
        hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.white[AppColors.colorCode80],
            ),
        hintText: LocaleKeys.search_enterSearch.tr(),
        prefixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search_rounded,
            color: AppColors.white[AppColors.colorCode80],
            size: 30,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
          },
          icon: Icon(
            Icons.close_rounded,
            color: AppColors.white[AppColors.colorCode80],
          ),
        ),
      ),
    );
  }

  //* widget latest searches
  Widget _ListLatestSearches(List<Item> items) {
    return Column(
      children: [
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                LocaleKeys.search_lastSearch.tr(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // AppDialog.showMessage(
                  //   title: LocaleKeys.search_titleDeleteDialog.tr(),
                  //   message: LocaleKeys.search_desTitleDeleteDialog.tr(),
                  //   titleAction1: LocaleKeys.search_doneDeleteDialog.tr(),
                  //   titleAction2: LocaleKeys.search_cancelDialog.tr(),
                  //   onPressedAction1: () {},
                  //   onPressedAction2: () {
                  //     context.pop();
                  //   },
                  //   context: context,
                  //   titleStyle: AppTextStyle.size18.copyWith(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   messageStyle: AppTextStyle.size14.copyWith(
                  //     color: AppColor.gray,
                  //   ),
                  // );
                },
                child: Text(
                  LocaleKeys.search_deleteAll.tr(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.red,
                      ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.all(5),
                title: Text(
                  items[index].itemTitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.gray,
                  ),
                  onPressed: () {},
                ),
                leading: const Icon(
                  Icons.history,
                  color: AppColors.black,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //* widget search results
  Widget _resultsWritingSearches(List<Item> items) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  cubit.getSearchResults();
                },
                contentPadding: const EdgeInsets.all(5),
                title: Text(
                  items[index].itemTitle,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.north_east,
                    color: AppColors.gray,
                  ),
                  onPressed: () {},
                ),
                leading: const Icon(
                  Icons.search_rounded,
                  color: AppColors.black,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //* widget search results
  Widget _resultsSearches() {
    return Container(
      color: AppColors.pink,
      width: 200,
      height: 200,
    );
    // return DefaultTabController(
    //   length: 4,
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Gap(10.h),
    //         TabBar(
    //           isScrollable: true,
    //           tabAlignment: TabAlignment.start,
    //           tabs: [
    //             Tab(text: LocaleKeys.search_all.tr()),
    //             Tab(text: LocaleKeys.search_food.tr()),
    //             Tab(text: LocaleKeys.search_stores.tr()),
    //             Tab(text: LocaleKeys.search_category.tr()),
    //           ],
    //           onTap: (index) {},
    //         ),
    //         Gap(10.h),
    //         SizedBox(
    //           height: 33.h,
    //           child: ListView(
    //             shrinkWrap: true,
    //             physics: const BouncingScrollPhysics(),
    //             scrollDirection: Axis.horizontal,
    //             children: [
    //               CustomMenuBar(
    //                 title: LocaleKeys.search_sortBy.tr(),
    //                 haveImport: true,
    //                 haveArrowDown: true,
    //                 onTap: () {},
    //               ),
    //               CustomMenuBar(
    //                 title: LocaleKeys.search_freeDelivery.tr(),
    //                 haveImport: false,
    //                 haveArrowDown: false,
    //                 onTap: () {},
    //               ),
    //               CustomMenuBar(
    //                 title: LocaleKeys.search_fastDelivery.tr(),
    //                 haveImport: false,
    //                 haveArrowDown: false,
    //                 onTap: () {},
    //               ),
    //               CustomMenuBar(
    //                 title: LocaleKeys.search_colosestToYou.tr(),
    //                 haveImport: false,
    //                 haveArrowDown: false,
    //                 onTap: () {},
    //               ),
    //               CustomMenuBar(
    //                 title: LocaleKeys.search_dependingOnYourTheTypOfFood.tr(),
    //                 haveImport: false,
    //                 haveArrowDown: true,
    //                 onTap: () {},
    //               )
    //             ],
    //           ),
    //         ),
    //         Gap(16.h),
    //         const CustomPageItem(
    //           title: "بازوكا",
    //           image: imagePreviousRequests,
    //           timeArrive: "22",
    //           isFreeDelivery: false,
    //           priceArrive: 22,
    //           numberRate: 3000,
    //           rate: 4.5,
    //           haveDiscount: true,
    //           discount: 40,
    //         ),
    //         Gap(16.h),
    //         SizedBox(
    //           height: 200.w,
    //           child: ListView.builder(
    //             physics: const BouncingScrollPhysics(),
    //             scrollDirection: Axis.horizontal,
    //             itemCount: 5,
    //             shrinkWrap: true,
    //             itemBuilder: (context, index) => CustomProduct(
    //               image: imageFood2,
    //               title: "وجبة تيستى برجر",
    //               price: 70,
    //               priceAfterDiscount: 80,
    //               haveDiscount: index == 0 ? true : false,
    //             ),
    //           ),
    //         ),
    //         Gap(16.h),
    //         const CustomPageItem(
    //           title: "توربيد",
    //           image: imagePreviousRequests2,
    //           timeArrive: "22",
    //           isFreeDelivery: true,
    //           priceArrive: 0,
    //           numberRate: 2332,
    //           rate: 4.5,
    //           haveDiscount: false,
    //           discount: 40,
    //         ),
    //         Gap(16.h),
    //         SizedBox(
    //           height: 200.w,
    //           child: ListView.builder(
    //             physics: const BouncingScrollPhysics(),
    //             scrollDirection: Axis.horizontal,
    //             itemCount: 5,
    //             shrinkWrap: true,
    //             itemBuilder: (context, index) => CustomProduct(
    //               image: imageFood3,
    //               title: "وجبة تيستى برجر",
    //               price: 50,
    //               priceAfterDiscount: 60,
    //               haveDiscount: index == 0 ? true : false,
    //             ),
    //           ),
    //         ),
    //         Gap(16.h),
    //       ],
    //     ),
    //   ),
    // );
  }

  //! controller
  late TextEditingController controller;
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// class CustomMenuBar extends StatelessWidget {
//   const CustomMenuBar({
//     super.key,
//     required this.title,
//     required this.haveImport,
//     required this.haveArrowDown,
//     required this.onTap,
//   });
//   final String title;
//   final bool haveImport;
//   final bool haveArrowDown;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50.r),
//           border: Border.all(color: AppColor.gray),
//           color: AppColor.white,
//         ),
//         height: 50.h,
//         padding: EdgeInsets.symmetric(horizontal: 10.w),
//         margin: EdgeInsets.symmetric(horizontal: 5.w),
//         child: Row(
//           children: [
//             haveImport
//                 ? Icon(
//                     Icons.import_export_outlined,
//                     size: 30.w,
//                   )
//                 : const SizedBox.shrink(),
//             Text(
//               title,
//               style: AppTextStyle.size14,
//             ),
//             haveArrowDown
//                 ? Icon(
//                     Icons.keyboard_arrow_down_rounded,
//                     size: 30.w,
//                   )
//                 : const SizedBox.shrink(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomPageItem extends StatelessWidget {
//   const CustomPageItem({
//     super.key,
//     required this.title,
//     required this.image,
//     required this.timeArrive,
//     required this.isFreeDelivery,
//     required this.priceArrive,
//     required this.numberRate,
//     required this.rate,
//     required this.haveDiscount,
//     required this.discount,
//   });
//   final String title;
//   final String image;
//   final String timeArrive;
//   final bool isFreeDelivery;
//   final num priceArrive;
//   final num numberRate;
//   final num rate;
//   final bool haveDiscount;
//   final num discount;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColor.gray),
//         borderRadius: BorderRadius.circular(8.r),
//         color: AppColor.white,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ImageUrlControllerWidget(
//             imageUrl: image,
//             borderRadius: BorderRadius.circular(8.r),
//             height: 70.h,
//             width: 70.w,
//           ),
//           Gap(10.w),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     title,
//                     style: AppTextStyle.size18.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Gap(MediaQuery.of(context).size.width * 0.4),
//                   CircleAvatar(
//                     backgroundColor: AppColor.grayBackground,
//                     radius: 14.r,
//                     child: SvgPicture.asset(
//                       IconsSvg.heart,
//                       height: 14.h,
//                       width: 14.w,
//                       color: AppColor.primary,
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Baseline(
//                     baseline: 12,
//                     baselineType: TextBaseline.alphabetic,
//                     child: SvgPicture.asset(
//                       IconsSvg.star,
//                       height: 14.5.h,
//                       width: 14.5.w,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Gap(5.w),
//                   Baseline(
//                     baseline: 12,
//                     baselineType: TextBaseline.alphabetic,
//                     child: Text(
//                       rate.toString(),
//                       style: AppTextStyle.size16.copyWith(
//                         fontWeight: FontWeight.bold,
//                         height: 1,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Gap(3.w),
//                   Baseline(
//                     baseline: 12,
//                     baselineType: TextBaseline.alphabetic,
//                     child: Text(
//                       "($numberRate)",
//                       style: AppTextStyle.size16.copyWith(
//                         color: AppColor.gray,
//                         height: 1,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Baseline(
//                     baseline: 12,
//                     baselineType: TextBaseline.alphabetic,
//                     child: Icon(
//                       Icons.access_time,
//                       color: AppColor.gray,
//                       size: 20,
//                     ),
//                   ),
//                   Gap(5.w),
//                   Baseline(
//                     baseline: 12,
//                     baselineType: TextBaseline.alphabetic,
//                     child: Text(
//                       "$timeArrive دقيقة",
//                       style: AppTextStyle.size16.copyWith(
//                         color: AppColor.gray,
//                       ),
//                     ),
//                   ),
//                   Gap(5.w),
//                   Baseline(
//                     baseline: 12,
//                     baselineType: TextBaseline.alphabetic,
//                     child: CircleAvatar(
//                       backgroundColor: AppColor.gray,
//                       radius: 3.r,
//                     ),
//                   ),
//                   Gap(8.w),
//                   Baseline(
//                     baseline: 12,
//                     baselineType: TextBaseline.alphabetic,
//                     child: SvgPicture.asset(IconsSvg.deliveryScooter),
//                   ),
//                   Gap(5.w),
//                   Baseline(
//                     baseline: 12,
//                     baselineType: TextBaseline.alphabetic,
//                     child: Text(
//                       isFreeDelivery ? "مجاني" : "$priceArrive د.ي",
//                       style: AppTextStyle.size16.copyWith(
//                         color: AppColor.gray,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(10.h),
//               haveDiscount
//                   ? Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 8.w,
//                         vertical: 10.h,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.r),
//                         color: AppColor.offer,
//                       ),
//                       child: Text(
//                         "خصم $discount% على بعض المنتجات",
//                         style: AppTextStyle.size14.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     )
//                   : const SizedBox.shrink(),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class CustomProduct extends StatelessWidget {
//   const CustomProduct({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.price,
//     required this.priceAfterDiscount,
//     required this.haveDiscount,
//   });
//   final String image;
//   final String title;
//   final num price;
//   final num priceAfterDiscount;
//   final bool haveDiscount;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColor.gray),
//         borderRadius: BorderRadius.circular(8.r),
//         color: AppColor.white,
//       ),
//       width: 130.w,
//       height: 180.h,
//       margin: EdgeInsets.symmetric(horizontal: 8.w),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               ImageUrlControllerWidget(
//                 imageUrl: image,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8.r),
//                   topRight: Radius.circular(8.r),
//                 ),
//                 height: 100.h,
//                 width: 130.w,
//               ),
//               Positioned(
//                 top: 8,
//                 left: 8,
//                 child: CircleAvatar(
//                   backgroundColor: AppColor.white,
//                   radius: 15.r,
//                   child: SvgPicture.asset(
//                     IconsSvg.heart,
//                     height: 18.h,
//                     width: 18.w,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Gap(8.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: AppTextStyle.size16,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Gap(4.h),
//                 Row(
//                   children: [
//                     Text(
//                       "$price د.ي",
//                       style: AppTextStyle.size16.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.start,
//                     ),
//                     Gap(8.w),
//                     haveDiscount
//                         ? Text(
//                             "$priceAfterDiscount د.ي",
//                             style: AppTextStyle.size16.copyWith(
//                               color: AppColor.gray,
//                               decoration: TextDecoration.lineThrough,
//                               decorationColor: AppColor.black,
//                               decorationThickness: 10.w,
//                             ),
//                             textAlign: TextAlign.start,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           )
//                         : const SizedBox.shrink(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
