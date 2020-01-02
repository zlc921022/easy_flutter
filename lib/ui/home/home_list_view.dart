import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/home/home_coming_movie.dart';
import 'package:flutter_movie/ui/home/home_head_banner.dart';
import 'package:flutter_movie/ui/home/home_top_movie.dart';
import 'package:flutter_movie/ui/home/home_top_movie_list.dart';

class HomeListView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new ListView(
      addAutomaticKeepAlives: true,
      children: <Widget>[
        new HomeHeadBanner(),
        new HomeTopMovie(),
        new HomeComingMovie(),
        new HomeTopMovieList(),
      ],
    );
  }
}