import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvvm/common/app_color.dart';
import 'package:provider_mvvm/utils/screen_util.dart';

class MyHeadImage extends StatelessWidget {
  final String imageUrl =
      'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3796085848,2512140654&fm=26&gp=0.jpg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 248,
          width: ScreenUtil.width,
          color: AppColor.black,
          child: Opacity(
            opacity: 0.7,
            child: Image(
              image: CachedNetworkImageProvider(imageUrl),
              width: ScreenUtil.width,
              height: 188,
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            width: ScreenUtil.width,
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
                Text('小薇',
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
