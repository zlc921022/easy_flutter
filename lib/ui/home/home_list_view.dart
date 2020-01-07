import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/home/home_coming_movie.dart';
import 'package:flutter_movie/ui/home/home_head_banner.dart';
import 'package:flutter_movie/ui/home/home_top_movie.dart';
import 'package:flutter_movie/ui/home/home_top_movie_list.dart';
import 'package:flutter_movie/viewmodel/home_view_model.dart';

/// 首页列表
class HomeListView extends StatelessWidget{

  final HomeViewModel model;
  HomeListView(this.model);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      addAutomaticKeepAlives: true,
      cacheExtent: 10 * 1000.0,
      children: <Widget>[
        new HomeHeadBanner(model.newsBannerData),
        new HomeTopMovie(model.nowPlayData),
        new HomeComingMovie(model.comingData),
        new HomeTopMovieList(),
      ],
    );
  }
}