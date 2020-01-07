import 'package:flutter_movie/base/base_result.dart';
import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/repository/actor_repository.dart';

class ActorViewModel extends BaseViewModel<ActorRepository> {
  @override
  ActorRepository createRepository() {
    return new ActorRepository();
  }

  /// 影片剧照
  Future<dynamic> getMovieAlbum({String movieId, int start, int count}) async {
    var result = await requestData(mRepository.getMovieAlbum(
        movieId: movieId, start: start, count: count));
    return result?.data['photos'];
  }

  /// 演员详细信息
  Future<dynamic> getActorDetail(String actorId) async {
    var result = await requestData(mRepository.getActorDetail(actorId));
    return result?.data;
  }

  /// 获取演员相册
  Future<dynamic> getActorPhotos({String actorId, int start, int count}) async {
    var result = await requestData(mRepository.getActorPhotos(
        actorId: actorId, start: start, count: count));
    return result?.data['photos'];
  }
}
