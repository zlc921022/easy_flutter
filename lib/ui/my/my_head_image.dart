import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/util/screen.dart';

class MyHeadImage extends StatelessWidget {
  final String imageUrl =
      'http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1205/24/c1/11732978_1337845452078.jpg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 248,
          width: Screen.width,
          color: AppColor.black,
          child: Opacity(
            opacity: 0.7,
            child: Image(
              image: CachedNetworkImageProvider(imageUrl),
              width: Screen.width,
              height: 188,
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            width: Screen.width,
            height: 248,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(imageUrl),
                  radius: 50.0,
                ),
                SizedBox(height: 10),
                Text('xiaocheng',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        )
      ],
    );
  }
}
