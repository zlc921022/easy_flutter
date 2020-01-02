import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/home_title_view.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../util/screen.dart';

class HomeTopMovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            HomeTitleView('电影榜单'),
          ],
        ),
        Text(
          '我是电影榜单栏目',
        ).intoCenter().intoContainer(
              width: Screen.width,
              height: 120,
            )
      ],
    ).intoContainer(
        color: AppColor.white, margin: const EdgeInsets.only(bottom: 10));
  }
}
