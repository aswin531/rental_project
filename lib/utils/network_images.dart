import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final BoxFit fit;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 15.0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 185,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              Image.asset('assets/images/placeholder-image.jpg'),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(borderRadius)),
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
