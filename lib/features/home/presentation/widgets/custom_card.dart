import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flowery_app/features/home/domain/entity/best_seller_response_entity.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:flutter/material.dart';

sealed class TypeCard {}

class BestSellerCard extends TypeCard {
  BestSellerCard({required this.bestSellerEntity});
  final BestSellerEntity bestSellerEntity;
}

class OccasionCard extends TypeCard {
  OccasionCard({required this.occasionEntity});
  final OccasionEntity occasionEntity;
}

abstract class FactoryCardsWidget {
  static CustomCardWidget cardType(TypeCard type) {
    switch (type) {
      case BestSellerCard():
        return BestSellerCardWidget(type);
      case OccasionCard():
        return OccasionCardWidget(type);
    }
  }
}

abstract class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({super.key});

  @override
  Widget build(BuildContext context);
}

class BestSellerCardWidget extends CustomCardWidget {
  const BestSellerCardWidget(this.bestSellerCard, {super.key});
  final BestSellerCard bestSellerCard;

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
            child: CustomCacheNetworkImage(
              imageUrl: bestSellerCard.bestSellerEntity.imgCover,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            bestSellerCard.bestSellerEntity.title,
            style: theme.bodyLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 3),
          Text(
            '${bestSellerCard.bestSellerEntity.price} EGP',
            style: theme.labelMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}

class OccasionCardWidget extends CustomCardWidget {
  const OccasionCardWidget(this.occasionCard, {super.key});
  final OccasionCard occasionCard;
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
            child: CustomCacheNetworkImage(
              imageUrl: occasionCard.occasionEntity.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          const SizedBox(height: 5),
          Text(occasionCard.occasionEntity.name, style: theme.labelMedium)
        ],
      ),
    );
  }
}
