import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/actor/actor_detail_view.dart';
import 'package:flutter_movie/ui/actor/actor_photos_view.dart';
import 'package:flutter_movie/ui/common/common_photo_view.dart';
import 'package:flutter_movie/ui/common/common_web_view.dart';
import 'package:flutter_movie/ui/movie/movie_detail_list.dart';
import 'package:flutter_movie/ui/movie/movie_list_view.dart';

class AppNavigator {
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void toWebView(BuildContext context, {String url, String title}) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                CommonWebView(url, title ?? title)));
  }

  static void toMovieDetail(BuildContext context,{MovieItem movieItem}) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => MovieDetailList(movieItem.id)));
  }

  static void toActorDetail(BuildContext context,String actorId) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ActorDetailView(actorId)));
  }

  static void toMovieList(BuildContext context, String title, String action) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MovieListView(action, title)));
  }

  static void toPhotoList(BuildContext context, String title,{String action,String id}) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ActorPhotosView(title,id,action: action,)));
  }

  static void toPhotoViewGallery(
      BuildContext context, List<String> images, int initIndex) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new CommonPhotoView(imageUrls: images, initIndex: initIndex);
    }));
  }
}
