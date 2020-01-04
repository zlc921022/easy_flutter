import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:widget_chain/widget_chain.dart';

class CommonRoundedImage extends StatelessWidget {
  final String imageUrl;
  double width;
  double height;

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
