import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/repository/actor_repository.dart';

class ActorViewModel extends BaseViewModel<ActorRepository> {
  @override
  ActorRepository createRepository() {
    return new ActorRepository();
  }

  @override
  void dispose() {}

  /// 影片剧照
  Future<dynamic> getMovieAlbum({String movieId, int start, int count}) async {
    return mRepository.getMovieAlbum(
        movieId: movieId, start: start, count: count);
  }

  /// 演员详细信息
  Future<dynamic> getActorDetail(String actorId) async {
    return mRepository.getActorDetail(actorId);
  }

  /// 获取演员相册
  Future<dynamic> getActorPhotos({String actorId, int start, int count}) async {
    return mRepository.getActorPhotos(
        actorId: actorId, start: start, count: count);
  }
}
