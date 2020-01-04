import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/common_web_view.dart';
import 'package:flutter_movie/ui/movie/list/movie_detail_list.dart';

class AppNavigator {
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void toWebView(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                CommonWebView('https://www.baidu.com', '百度')));
  }

  static void toMovieDetail(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                MovieDetailList()));
  }
}
