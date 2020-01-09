import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_banner.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/home/banner_circle_point.dart';
import 'package:flutter_movie/ui/home/banner_item_view.dart';

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
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.only(bottom: 5,top: 5),
      child:  Stack(
        children: <Widget>[
          CarouselSlider.builder(
            // banner所占屏幕比例
            viewportFraction: 0.8,
            itemCount: widget.banners?.length,
            itemBuilder: (context, index) {
              NewsBanner banner = widget.banners[index];
              return new BannerItemView(banner);
            },
            aspectRatio: 2,
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
        ],
      ),
    );
  }
}
