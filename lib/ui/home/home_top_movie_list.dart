import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/home_title_view.dart';
import 'package:flutter_movie/ui/home/top_list_item_view.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../util/screen.dart';

class HomeTopMovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeTopMovieListState();
  }
}

class HomeTopMovieListState extends State{

  int _currentIndex = 1;
  var imageList = [
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg',
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg',
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            HomeTitleView('电影榜单'),
          ],
        ),
        SizedBox(height: 12),
        CarouselSlider.builder(
          // banner所占屏幕比例
          viewportFraction: 0.8,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return new TopListItemView(imageList[index]);
          },
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ],
    ).intoContainer(
        color: AppColor.white, padding: const EdgeInsets.all(10),margin: EdgeInsets.only(bottom: 5));
  }

}
