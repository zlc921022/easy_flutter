import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/home/banner_circle_point.dart';
import 'package:flutter_movie/ui/home/banner_item_view.dart';
import 'package:widget_chain/widget_chain.dart';

class HomeHeadBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeHeadBannerState();
  }
}

class HomeHeadBannerState extends State<HomeHeadBanner> {
  int _currentIndex = 1;
  var imageList = [
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg',
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg',
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg',
  ];

  /// 创建小圆点集合
  List<Widget> createPoints() {
    List<Widget> points = [];
    for (int i = 0; i < imageList.length; i++) {
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
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return new BannerItemView(imageList[index], '测试标题', '测试摘要啊啊');
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: createPoints(),
        ).intoPositioned(left: 0, right: 0, top: 0, bottom: 0),
      ],
    ).intoContainer(
        color: AppColor.white, padding: EdgeInsets.only(bottom: 10));
  }
}
