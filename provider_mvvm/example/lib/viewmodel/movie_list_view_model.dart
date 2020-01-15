import 'package:provider_mvvm/base/base_view_model.dart';

import '../repository/movie_repository.dart';

/// 电影列表ViewModel
class MovieListViewModel extends BaseViewModel<MovieRepository> {
  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await requestData(
        mRepository.getComingList(start: start, count: count));
    if (result != null && result.data != null) {
      return result.data['subjects'];
    } else {
      return null;
    }
  }

  @override
  MovieRepository createRepository() {
    return new MovieRepository();
  }
}
