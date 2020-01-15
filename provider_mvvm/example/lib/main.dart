import 'package:example/movie_data_util.dart';
import 'package:example/movie_list_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvvm/base/provider_widget.dart';
import 'package:provider_mvvm/base/view_state_widget.dart';
import 'package:provider_mvvm/common/app_color.dart';

import 'model/movie_item.dart';
import 'repository/movie_repository.dart';
import 'viewmodel/movie_list_view_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: '电影列表'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  State<StatefulWidget> createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  /// 是否加载更多
  bool _loadMore = false;

  /// 是否是刷新
  bool _refresh = false;
  int start = 0;
  int count = 20;
  List<MovieItem> movieData = [];
  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieListViewModel, MovieRepository>(
        model: MovieListViewModel(),
        initData: (model) {
          addListener(model);
          loadMoreData(model: model);
        },
        builder: (context, model, child) {
          if (model.isLoading() && !_refresh && !model.isLoadMore) {
            return CommonViewStateHelper(
                model: model,
                onEmptyPressed: () {
                  loadMoreData(model: model);
                },
                onErrorPressed: () {
                  loadMoreData(model: model);
                });
          }
          return Scaffold(
              appBar: AppBar(
                  title: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: AppColor.white),
              )),
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
                                movieItem, 'coming_soon');
                          })),
                  onRefresh: () {
                    return refreshData(model: model);
                  }));
        });
  }

  /// 添加监听
  void addListener(MovieListViewModel model) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_loadMore) {
          _loadMore = false;
          model.isLoadMore = true;
          loadMoreData(model: model);
        }
      }
    });
  }

  /// 刷新数据
  Future<void> refreshData({@required MovieListViewModel model}) async {
    start = 0;
    count = 20;
    _refresh = true;
    var newMovies = await loadData(model);
    _refresh = false;
    this.movieData.clear();
    if (newMovies != null) {
      this.movieData.addAll(newMovies);
    }
    refreshState(model: model);
  }

  /// 加载更多数据
  Future<void> loadMoreData({@required MovieListViewModel model}) async {
    var newMovies = await loadData(model);
    if (newMovies != null && newMovies.length > 0) {
      this.movieData.addAll(newMovies);
      start = start + count;
      model.isLoadMore = true;
      _loadMore = true;
    } else {
      _loadMore = false;
      model.isLoadMore = false;
    }
    refreshState(model: model);
  }

  Future<dynamic> loadData(MovieListViewModel model) async {
    var list = await model.getComingList(start: start, count: count);
    return MovieDataUtil.getMovieList(list);
  }

  /// 刷新状态
  void refreshState({@required MovieListViewModel model}) {
    if (movieData.isEmpty) {
      model.setEmpty();
    } else {
      model.setSuccess();
    }
  }
}
