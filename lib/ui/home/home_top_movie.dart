import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/home_look_all_view.dart';
import 'package:flutter_movie/ui/common/home_title_view.dart';
import 'package:flutter_movie/ui/home/top_movie_item.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../util/toast.dart';

class HomeTopMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            HomeTitleView('影院热映'),
            HomeLookAllView(
              () {
                Toast.show('查看更多');
              },
            ).intoExpanded(),
          ],
        ),
        GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.55),
                itemBuilder: (context, index) {
                  return TopMovieItem();
                })
            .intoContainer(margin: const EdgeInsets.all(12)),
      ],
    ).intoContainer(
      color: AppColor.white,
      margin: const EdgeInsets.only(bottom: 5)
    );
  }
}
