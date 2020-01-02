import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../util/screen.dart';

class CommonRoundedImage extends StatelessWidget {
  final String imageUrl;

  CommonRoundedImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    double width = (Screen.width - 4 * 12) / 3;
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: width / 0.75,
    ).intoClipRRect(
      borderRadius: BorderRadius.circular(4),
    );
  }
}
