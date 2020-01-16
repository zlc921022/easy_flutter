import 'package:flutter_movie/data/api/app_api.dart';

import 'base_repository.dart';

/// 演员相关的
class ActorRepository extends BaseMovieRepository {
  /// 影片剧照
  Future<dynamic> getMovieAlbum({String movieId, int start, int count}) async {
    var result = await get(ApiService.getMovieStagePhoto(movieId),
        params: {'start': start, 'count': count});
    return result;
  }

  /// 演员详细信息
  Future<dynamic> getActorDetail(String actorId) async {
    var result = await get(ApiService.getActorDetail(actorId));
    return result;
  }

  /// 获取演员相册
  Future<dynamic> getActorPhotos({String actorId, int start, int count}) async {
    var result = await get(ApiService.getActorPhotos(actorId),
        params: {'start': start, 'count': count});
    return result;
  }
}
