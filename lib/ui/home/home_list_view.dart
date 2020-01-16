import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_banner.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/repository/home_respository.dart';
import 'package:flutter_movie/ui/home/home_coming_movie.dart';
import 'package:flutter_movie/ui/home/home_head_banner.dart';
import 'package:flutter_movie/ui/home/home_top_movie.dart';
import 'package:flutter_movie/ui/home/home_top_movie_list.dart';
import 'package:flutter_movie/util/movie_data_util.dart';
import 'package:flutter_movie/viewmodel/home_view_model.dart';
import 'package:provider_mvvm/base/provider_widget.dart';
import 'package:provider_mvvm/base/view_state_widget.dart';

/// 首页列表
class HomeListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  List<NewsBanner> newsBannerData;
  List<MovieItem> comingData;
  List<MovieItem> nowPlayData;
  int start = 0;
  int count = 6;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel, HomeRepository>(
        model: HomeViewModel(),
        initData: (model) {
          loadData(model);
        },
        builder: (context, model, child) {
          if (!model.isSuccess()) {
            return CommonViewStateHelper(
                model: model,
                onEmptyPressed: () {
                  loadData(model);
                },
                onErrorPressed: () {
                  loadData(model);
                });
          }
          return new Container(
              child: new ListView(
                addAutomaticKeepAlives: true,
                cacheExtent: 10 * 1000.0,
                children: <Widget>[
                  new HomeHeadBanner(newsBannerData),
                  new HomeTopMovie(nowPlayData),
                  new HomeComingMovie(comingData),
                  new HomeTopMovieList(),
                ],
              ));
        });
  }

  /// 加载数据
  Future<dynamic> loadData(HomeViewModel model) async {
    model.setLoading();
    var newsList = await model.getNewsList();
    var nowPlaylist = await model.getNowPlayingList(start: start, count: count);
    var comingList = await model.getComingList(start: start, count: count);
    this.newsBannerData = _news2Banner(newsList);
    this.comingData = MovieDataUtil.getMovieList(comingList);
    this.nowPlayData = MovieDataUtil.getMovieList(nowPlaylist);
    if (isEmpty()) {
      model.setEmpty();
    } else {
      model.setSuccess();
    }
  }

  bool isEmpty() {
    if (newsBannerData == null ||
        comingData == null ||
        nowPlayData == null ||
        newsBannerData.isEmpty ||
        comingData.isEmpty ||
        nowPlayData.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  List<NewsBanner> _news2Banner(var list) {
    if (list == null) {
      return null;
    }
    List content = list;
    List<NewsBanner> banners = [];
    content.forEach((data) {
      banners.add(NewsBanner(data));
    });
    return banners;
  }
}
