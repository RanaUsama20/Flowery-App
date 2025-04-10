import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_app/core/common/animation/loading_shimmer.dart';
import 'package:flutter/material.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  const CustomCacheNetworkImage({required this.imageUrl, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      width: double.infinity,
      height: height ?? double.infinity,
      fadeOutDuration: Duration(milliseconds: 500),
      errorWidget: (context, url, error) {
        return LoadingShimmer(
          height: double.infinity,
          width: double.infinity,
        );
      },
      placeholder: (context, url) {
        return LoadingShimmer(
          height: double.infinity,
          width: double.infinity,
        );
      },
    );
  }
}
