import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:widget_chain/widget_chain.dart';

class MovieTopHeadView extends StatelessWidget {
  String imageUrl =
      'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: Screen.width,
          height: 218 + Screen.topSafeHeight,
          color: AppColor.black_33,
          child: Opacity(
            opacity: 0.3,
            child: Image(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
              width: Screen.width,
              height: 218 + Screen.topSafeHeight,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            AppNavigator.back(context);
          },
          child: Image.asset('images/icon_arrow_back_white.png'),
        ).intoContainer(margin: EdgeInsets.only(left: 15, top: 30)),
        Container(
          width: Screen.width,
          height: 218 + Screen.topSafeHeight,
          margin: const EdgeInsets.only(left: 30),
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('每周五更新 共10部',
                  style: TextStyle(fontSize: 14, color: AppColor.white)),
              SizedBox(height: 20),
              Text('一周口碑电影榜',
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
