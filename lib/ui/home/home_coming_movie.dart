import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/home_look_all_view.dart';
import 'package:flutter_movie/ui/common/home_section_title.dart';
import 'package:flutter_movie/ui/home/coming_movie_staggered_grid_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider_mvvm/common/app_color.dart';

/// 即将上映
class HomeComingMovie extends StatelessWidget {
  final List<MovieItem> comingMovies;
  final ScrollController controller;

  HomeComingMovie(this.comingMovies, {this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      color: AppColor.white,
      child: new Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              HomeSectionTitle('即将上映'),
              Expanded(
                child: HomeLookAllView(() {
                  AppNavigator.pushMovieList(context, '即将上映', 'coming_soon');
                }),
              )
            ],
          ),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            itemCount: comingMovies.length,
            itemBuilder: (BuildContext context, int index) {
              var movieItem = comingMovies[index];
              return ComingMovieStaggeredGridItem(movieItem);
            },
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(1, index == 0 ? 1.5 : 1.7),
          )
// 9宫格布局
//          Container(
//            margin: const EdgeInsets.all(12),
//            child: GridView.builder(
//                shrinkWrap: true,
//                itemCount: comingMovies.length,
//                physics: NeverScrollableScrollPhysics(),
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 3,
//                    mainAxisSpacing: 12,
//                    crossAxisSpacing: 12,
//                    childAspectRatio: 0.52),
//                itemBuilder: (context, index) {
//                  var movieItem = comingMovies[index];
//                  return ComingMovieItem(movieItem);
//                }),
//          )
        ],
      ),
    );
  }
}
