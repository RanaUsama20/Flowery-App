import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_app/core/common/animation/loading_shimmer.dart';
import 'package:flutter/material.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isCircular;
  final BorderRadius? borderRadius;

  const CustomCacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isCircular = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => _buildShimmer(),
      errorWidget: (context, url, error) => _buildShimmer(),
      fadeOutDuration: const Duration(milliseconds: 500),
    );

    if (isCircular) {
      return ClipOval(child: image);
    } else if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius ?? BorderRadius.zero, child: image);
    } else {
      return image;
    }
  }

  Widget _buildShimmer() {
    return LoadingShimmer(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      isCircular: isCircular,
      borderRadius: borderRadius,
    );
  }
}
