import 'package:flutter_movie/model/movie_item.dart';
import 'package:palette_generator/palette_generator.dart';

/// 电影榜单bean对象
class MovieTopBanner {
  List<MovieItem> movies;
  String title;
  String subTitle;
  String action;
  PaletteColor coverColor;

  MovieTopBanner(
      this.movies, this.title, this.subTitle, this.action, this.coverColor);
}
