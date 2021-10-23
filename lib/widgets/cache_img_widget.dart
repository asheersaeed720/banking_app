import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImgWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final bool isProfilePic;
  final double borderRadius;

  const CacheImgWidget(
    this.imageUrl, {
    Key? key,
    this.width = 44.0,
    this.height = 44.0,
    this.borderRadius = 8.0,
    this.isProfilePic = false,
  }) : super(key: key);

  final String noImageAvailable = "assets/images/no_img_available.jpg";

  @override
  Widget build(BuildContext context) {
    try {
      return ClipRRect(
        borderRadius: isProfilePic == false
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.circular(32.0),
        child: CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Image.asset('assets/images/placeholder_loading.gif'),
          errorWidget: (context, url, error) => Image.asset(noImageAvailable, fit: BoxFit.cover),
        ),
      );
    } catch (e) {
      return Image.asset(noImageAvailable, fit: BoxFit.cover);
    }
  }
}
