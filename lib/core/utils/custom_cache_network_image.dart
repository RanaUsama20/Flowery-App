import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  const CustomCacheNetworkImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
      placeholder: (context, url) {
        return CircularProgressIndicator();
      },
    );
  }
}
