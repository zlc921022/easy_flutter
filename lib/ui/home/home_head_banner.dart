import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_banner.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/home/banner_circle_point.dart';
import 'package:flutter_movie/ui/home/banner_item_view.dart';
import 'package:widget_chain/widget_chain.dart';
/// 首页banner部分
class HomeHeadBanner extends StatefulWidget {

  final List<NewsBanner> banners;
  HomeHeadBanner(this.banners);

  @override
  State<StatefulWidget> createState() {
    return new HomeHeadBannerState();
  }
}

class HomeHeadBannerState extends State<HomeHeadBanner> {
  int _currentIndex = 1;

  /// 创建小圆点集合
  List<Widget> createPoints() {
    List<Widget> points = [];
    for (int i = 0; i < widget.banners.length; i++) {
      points.add(BannerCirclePoint(_currentIndex == i));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider.builder(
          // banner所占屏幕比例
          viewportFraction: 0.8,
          itemCount: widget.banners?.length,
          itemBuilder: (context, index) {
            NewsBanner banner = widget.banners[index];
            return new BannerItemView(banner);
          },
          autoPlay: true,
          // 是否允许大图片居中显示
          enlargeCenterPage: true,
          autoPlayInterval: const Duration(seconds: 3),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
/// 创建小圆点
//        Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.end,
//          children: createPoints(),
//        ).intoPositioned(left: 0, right: 0, top: 0, bottom: 10),
      ],
    ).intoContainer(
        color: AppColor.white, padding: EdgeInsets.only(bottom: 10));
  }
}
