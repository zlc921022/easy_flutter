import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/base/view_state_widget.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_app_bar.dart';
import 'package:flutter_movie/ui/movie/detail/movie_list_item_view.dart';
import 'package:flutter_movie/util/movie_data_util.dart';
import 'package:flutter_movie/viewmodel/movie_list_view_model.dart';

/// 电影列表
class MovieListView extends StatefulWidget {
  final String action;
  final String title;

  MovieListView(this.action, this.title);

  @override
  State<StatefulWidget> createState() {
    return new MovieListViewState();
  }
}

class MovieListViewState extends State<MovieListView> {
  /// 是否还有更多
  bool _loadMore = false;

  /// 是否是刷新
  bool _refresh = false;
  int start = 0;
  int count = 20;
  List<MovieItem> movieData = [];

  ScrollController _scrollController = ScrollController();

  /// 添加滑动监听
  void addListener(MovieListViewModel model) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_loadMore) {
          _loadMore = false;
          model.isLoadMore = true;
          loadData(model);
        }
      }
    });
  }

  /// 加载数据
  Future<dynamic> loadData(MovieListViewModel model,
      {isRefresh = false}) async {
    var list;
    _refresh = isRefresh;
    if (widget.action == 'coming_soon') {
      list = await model.getComingList(start: start, count: count);
    } else if (widget.action == 'top_movie') {
      list = await model.getNowPlayingList(start: start, count: count);
    }
    var newMovies = MovieDataUtil.getMovieList(list);
    if (newMovies != null && newMovies.length > 0) {
      if (isRefresh) {
        this.movieData.clear();
        this.movieData.addAll(newMovies);
        _refresh = false;
      } else {
        this.movieData.addAll(newMovies);
        _loadMore = true;
        start = start + count;
      }
    } else {
      _loadMore = false;
      model.isLoadMore = false;
    }
    if (movieData.isEmpty) {
      model.setEmpty();
    } else {
      model.setSuccess();
    }
  }

  Future<void> refreshData({@required MovieListViewModel model}) async {
    start = 0;
    count = 20;
    await Future.delayed(Duration(milliseconds: 1000), () {
      loadData(model, isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieListViewModel, MovieRepository>(
        model: MovieListViewModel(),
        initData: (model) {
          loadData(model);
          addListener(model);
        },
        builder: (context, model, child) {
          if (!model.isSuccessShowDataState()) {
            return new CommonViewStateHelper(
                model: model,
                onEmptyPressed: () {
                  loadData(model);
                },
                onErrorPressed: () {
                  loadData(model);
                });
          }
          return Scaffold(
              appBar: CommonAppBar(context, this.widget.title),
              body: RefreshIndicator(
                  child: Container(
                      color: AppColor.white,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: movieData.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            if (_loadMore && (index + 1) == movieData.length) {
                              return Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              );
                            }
                            MovieItem movieItem = movieData[index];
                            return new MovieListItemView(
                                movieItem, this.widget.action);
                          })),
                  onRefresh: () {
                    return refreshData(model: model);
                  }));
        });
  }
}
