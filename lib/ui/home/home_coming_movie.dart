import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/home_look_all_view.dart';
import 'package:flutter_movie/ui/common/home_title_view.dart';
import 'package:flutter_movie/ui/home/coming_movie_item.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../util/toast.dart';

class HomeComingMovie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeComingMovieState();
  }
}

class HomeComingMovieState extends State<HomeComingMovie> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            HomeTitleView('即将上映'),
            HomeLookAllView(() {
              Toast.show('查看更多');
            }).intoExpanded(),
          ],
        ),
        GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                childAspectRatio: 1),
            itemBuilder: (context, index) {
              return ComingMovieItem();
            }),
      ],
    ).intoContainer(color: AppColor.white, margin: EdgeInsets.only(bottom: 5));
  }
}
