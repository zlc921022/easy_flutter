import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/home_look_all_view.dart';
import 'package:flutter_movie/ui/common/home_title_view.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../util/screen.dart';
import '../../util/toast.dart';

class HomeTopMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            HomeTitleView('影院热映'),
            HomeLookAllView(() {
              Toast.show('查看更多');
            },).intoExpanded(),
          ],
        ),
        Text(
          '我是影院热映的栏目',
        ).intoCenter().intoContainer(width: Screen.width, height: 120)
      ],
    ).intoContainer(
      color: AppColor.white,
      margin: const EdgeInsets.only(bottom: 5),
    );
  }
}
