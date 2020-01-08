import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/base/view_state.dart';
import 'package:flutter_movie/model/movie_actor_detail.dart';
import 'package:flutter_movie/model/movie_photo.dart';
import 'package:flutter_movie/repository/actor_repository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/util/movie_data_util.dart';
import 'package:palette_generator/palette_generator.dart';

// 演员对应ViewModel
class ActorViewModel extends BaseViewModel<ActorRepository> {
  MovieActorDetail actorDetail;
  List<MoviePhoto> moviePhotos;
  List<String> imagesUrls;
  Color actorDetailPageColor = AppColor.white;

  @override
  ActorRepository createRepository() {
    return new ActorRepository();
  }

  /// 影片剧照
  Future<dynamic> getMovieAlbum({String movieId, int start, int count}) async {
    var result = await requestData(mRepository.getMovieAlbum(
        movieId: movieId, start: start, count: count));
    var photos = result?.data['photos'];
    moviePhotos = MovieDataUtil.getPhotoList(photos);
    imagesUrls = await getImageUrls(moviePhotos);
    return photos;
  }

  /// 演员详细信息
  Future<dynamic> getActorDetail(String actorId) async {
    var result = await requestData(mRepository.getActorDetail(actorId));
    actorDetail = MovieActorDetail.fromJson(result?.data);
    PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(actorDetail.avatars.small),
    );
    if (generator.darkVibrantColor != null) {
      actorDetailPageColor = generator.darkMutedColor.color;
    } else {
      actorDetailPageColor = Color(0xff35374c);
    }
    setState(ViewState.loaded);
    return result?.data;
  }

  /// 获取演员相册
  Future<dynamic> getActorPhotos({String actorId, int start, int count}) async {
    var result = await requestData(mRepository.getActorPhotos(
        actorId: actorId, start: start, count: count));
    var photos = result?.data['photos'];
    moviePhotos = MovieDataUtil.getPhotoList(photos);
    imagesUrls = await getImageUrls(moviePhotos);
    return photos;
  }

  Future<List<String>> getImageUrls(List<MoviePhoto> photos) async {
    List<String> imageUrls = [];
    for (MoviePhoto photo in photos) {
      imageUrls.add(photo.cover);
    }
    return imageUrls;
  }
}
