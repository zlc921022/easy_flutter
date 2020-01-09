import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_banner.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/util/screen.dart';

/// 首页banner条目
class BannerItemView extends StatelessWidget {
  final NewsBanner newsBanner;

  BannerItemView(this.newsBanner);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
          onTap: () {
            AppNavigator.pushWebView(context,
                url: newsBanner.news?.link, title: newsBanner.news?.title);
          },
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image(
                  image: CachedNetworkImageProvider(newsBanner.news?.cover),
                  fit: BoxFit.cover,
                  width: Screen.width,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(newsBanner.news?.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColor.white)),
                    SizedBox(height: 2),
                    Text(newsBanner.news?.summary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: AppColor.white)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
