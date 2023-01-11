import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/color.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.imageUrl,
    required this.imageTypes,
    this.useIconColor = false,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  final String imageUrl;
  final ImageTypes imageTypes;
  final bool useIconColor;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty || imageUrl == 'null') {
      return Container(
        color: kcGrey400,
        child: const Center(child: Icon(Icons.broken_image_rounded)),
      );
    }

    // log(imageUrl);

    switch (imageTypes) {
      case ImageTypes.network:
        return Container(
          color: Colors.black,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            errorWidget: (_, __, ___) => Container(
              color: kcGrey400,
              child: const Center(
                child: Icon(Icons.error),
              ),
            ),
            placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );

      case ImageTypes.file:
        return Image.file(
          File(imageUrl),
          fit: fit,
          errorBuilder: (_, __, ___) => Container(
            color: kcGrey400,
            child: const Center(
              child: Icon(Icons.error),
            ),
          ),
        );
      case ImageTypes.asset:
        return Image.asset(
          imageUrl,
          fit: fit,
          errorBuilder: (_, __, ___) {
            // log(e.toString());
            return Container(
              color: kcGrey400,
              child: const Center(
                child: Icon(Icons.error),
              ),
            );
          },
        );

      case ImageTypes.none:
        return const Placeholder();

      case ImageTypes.profile:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          errorWidget: (_, __, ___) => Container(
            color: kcGrey400,
            child: const Center(child: Icon(Icons.person)),
          ),
          placeholder: (_, __) =>
              const Center(child: CircularProgressIndicator()),
        );
      case ImageTypes.svg:
        return SvgPicture.asset(
          imageUrl,
          color: useIconColor ? kcPrimaryColor.withOpacity(0.6) : null,
        );
    }
  }
}

enum ImageTypes { network, file, asset, profile, none, svg }
