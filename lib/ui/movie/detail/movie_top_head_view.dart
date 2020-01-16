import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvvm/common/app_color.dart';
import 'package:provider_mvvm/utils/screen_util.dart';
/// 电影榜单列表 头部
class MovieTopHeadView extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;

  MovieTopHeadView(this.title, this.subTitle, this.image);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil.width,
          height: 218 + ScreenUtil.topSafeHeight,
          color: Color(0xff000000),
          margin: const EdgeInsets.only(top: 0),
          child: Opacity(
            opacity: 0.3,
            child: Image(
              image: CachedNetworkImageProvider(image),
              fit: BoxFit.cover,
              width: ScreenUtil.width,
              height: 218 + ScreenUtil.topSafeHeight,
            ),
          ),
        ),
        Container(
          width: ScreenUtil.width,
          height: 218 + ScreenUtil.topSafeHeight,
          margin: const EdgeInsets.only(left: 30),
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(subTitle,
                  style: TextStyle(fontSize: 14, color: AppColor.white)),
              SizedBox(height: 20),
              Text(title,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
