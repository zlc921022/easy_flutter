import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 通用圆角图片控件
class CommonRoundedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  CommonRoundedImage(this.imageUrl, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image(
        image: CachedNetworkImageProvider(imageUrl),
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }
}
