import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/repository/home_respository.dart';

/// 首页ViewModel
class HomeViewModel extends BaseViewModel<HomeRepository> {
  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await mRepository.getComingList(start: start, count: count);
    if (result != null && result.data != null) {
      return result.data['subjects'];
    } else {
      return null;
    }
  }

  /// 获取正在上映的电影
  Future<dynamic> getNowPlayingList({int start, int count}) async {
    var result = await mRepository.getNowPlayingList(start: start, count: count);
    if (result != null && result.data != null) {
      return result.data['subjects'];
    } else {
      return null;
    }
  }

  ///  获取首页热门新闻文章
  Future<dynamic> getNewsList() async {
    return await mRepository.getNewsList();
  }

  @override
  HomeRepository createRepository() {
    return new HomeRepository();
  }
}
