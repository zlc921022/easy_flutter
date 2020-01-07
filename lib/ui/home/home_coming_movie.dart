import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/home_look_all_view.dart';
import 'package:flutter_movie/ui/common/home_title_view.dart';
import 'package:flutter_movie/ui/home/coming_movie_item.dart';
import 'package:widget_chain/widget_chain.dart';

/// 即将上映
class HomeComingMovie extends StatefulWidget {

  List<MovieItem> comingMovies;
  HomeComingMovie(this.comingMovies);

  @override
  State<StatefulWidget> createState() {
    return HomeComingMovieState();
  }
}

class HomeComingMovieState extends State<HomeComingMovie> {

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            HomeTitleView('即将上映'),
            HomeLookAllView(() {
              AppNavigator.toMovieList(context, '即将上映', 'coming_soon');
            }).intoExpanded(),
          ],
        ),
        GridView.builder(
            shrinkWrap: true,
            itemCount: widget.comingMovies?.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.52),
            itemBuilder: (context, index) {
              var movieItem = widget.comingMovies[index];
              return ComingMovieItem(movieItem);
            }).intoContainer(margin: const EdgeInsets.all(12)),
      ],
    ).intoContainer(color: AppColor.white, margin: EdgeInsets.only(bottom: 5));
  }
}
