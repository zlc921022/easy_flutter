import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/repository/home_respository.dart';

class HomeViewModel extends BaseViewModel<HomeRepository> {
  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    return await mRepository.getComingList(start: start, count: count);
  }

  /// 获取正在上映的电影
  Future<dynamic> getNowPlayingList({int start, int count}) async {
    return await mRepository.getNowPlayingList(start: start, count: count);
  }

  /// 获取本周口碑榜电影
  Future<dynamic> getWeeklyList() async {
    return await mRepository.getWeeklyList();
  }

  ///  获取首页热门新闻文章
  Future<dynamic> getNewsList() async {
    return await mRepository.getNewsList();
  }

  @override
  HomeRepository createRepository() {
    return new HomeRepository();
  }

  @override
  void dispose() {}
}
