import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/color.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.imageTypes,
    this.imageUrl,
    this.useIconColor = false,
    this.fit = BoxFit.fill,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  final String? imageUrl;
  final ImageTypes imageTypes;
  final bool useIconColor;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        height: height,
        width: width,
        color: color ?? kcGrey200,
        child: Center(
          child: Icon(
            imageTypes == ImageTypes.profile
                ? Icons.person
                : Icons.broken_image_rounded,
          ),
        ),
      );
    }

    // log(imageUrl);

    switch (imageTypes) {
      case ImageTypes.network:
        return Container(
          height: height,
          width: width,
          color: color,
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: fit,
            errorWidget: (_, __, ___) => Container(
              color: kcGrey200,
              child: const Center(
                child: Icon(Icons.error),
              ),
            ),
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );

      case ImageTypes.file:
        return SizedBox(
          height: height,
          width: width,
          child: Image.file(
            File(imageUrl!),
            fit: fit,
            color: color,
            errorBuilder: (_, __, ___) => Container(
              color: kcGrey200,
              child: const Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
        );
      case ImageTypes.asset:
        return SizedBox(
          height: height,
          width: width,
          child: Image.asset(
            imageUrl!,
            fit: fit,
            color: color,
            errorBuilder: (_, __, ___) {
              // log(e.toString());
              return Container(
                color: kcGrey200,
                child: const Center(
                  child: Icon(Icons.error),
                ),
              );
            },
          ),
        );

      case ImageTypes.none:
        return SizedBox(
          height: height,
          width: width,
          child: const Placeholder(),
        );

      case ImageTypes.profile:
        return CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: imageUrl!,
          fit: fit,
          color: color,
          errorWidget: (_, __, ___) => Container(
            color: kcGrey200,
            child: const Center(child: Icon(Icons.person)),
          ),
          placeholder: (_, __) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      case ImageTypes.svg:
        return SizedBox(
          height: height,
          width: width,
          child: SvgPicture.asset(
            imageUrl!,
            color: useIconColor
                ? (color ?? kcPrimaryColor.withOpacity(0.6))
                : null,
          ),
        );
    }
  }
}

enum ImageTypes { network, file, asset, profile, none, svg }
