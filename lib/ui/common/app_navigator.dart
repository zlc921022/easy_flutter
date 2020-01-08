import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/actor/actor_detail_view.dart';
import 'package:flutter_movie/ui/actor/actor_photos_view.dart';
import 'package:flutter_movie/ui/common/common_photo_view.dart';
import 'package:flutter_movie/ui/common/common_web_view.dart';
import 'package:flutter_movie/ui/movie/movie_detail_list.dart';
import 'package:flutter_movie/ui/movie/movie_list_view.dart';

/// app应用跳转管理
class AppNavigator {
  /// 返回
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  /// webView
  static void pushWebView(BuildContext context, {String url, String title}) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => CommonWebView(url, title ?? title)));
  }

  /// 电影详情
  static void pushMovieDetail(BuildContext context, {MovieItem movieItem}) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MovieDetailList(movieItem.id)));
  }

  /// 演员详情
  static void pushActorDetail(BuildContext context, String actorId) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ActorDetailView(actorId)));
  }

  /// 电影列表
  static void pushMovieList(BuildContext context, String title, String action) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MovieListView(action, title)));
  }

  /// 相册列表
  static void pushPhotoList(BuildContext context, String title,
      {String action, String id}) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ActorPhotosView(
                  title,
                  id,
                  action: action,
                )));
  }

  /// 查看图片
  static void toPhotoViewGallery(
      BuildContext context, List<String> images, int initIndex) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new CommonPhotoView(imageUrls: images, initIndex: initIndex);
    }));
  }
}
