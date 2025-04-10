import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flutter/material.dart';

enum TypeOfCard { Big, Small }

class CardOfItem {
  static CustomCard cardType(
      {required String image,
      String? title,
      int? price,
      required TypeOfCard type}) {
    if (type == TypeOfCard.Big) {
      return BigCard(
        image: image,
        price: price,
        title: title,
      );
    } else {
      return SmallCard(
        image: image,
        title: title!,
      );
    }
  }
}

abstract class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context);
}

class BigCard extends CustomCard {
  final String? image;
  final String? title;
  final int? price;
  const BigCard(
      {super.key,
      required this.image,
      required this.price,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 150, child: CustomCacheNetworkImage(imageUrl: image!)),
          const SizedBox(height: 5),
          Text(title!, style: theme.bodyLarge, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 3),
          Text('$price EGP', style: theme.labelMedium)
        ],
      ),
    );
  }
}

class SmallCard extends CustomCard {
  final String image;
  final String title;
  const SmallCard({super.key, required this.image, required this.title});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: CustomCacheNetworkImage(imageUrl: image),
          ),
          const SizedBox(height: 5),
          Text(title, style: theme.labelMedium)
        ],
      ),
    );
  }
}
