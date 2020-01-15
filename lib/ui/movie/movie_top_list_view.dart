import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/base/view_state_widget.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';
import 'package:flutter_movie/ui/movie/detail/movie_top_head_view.dart';
import 'package:flutter_movie/util/movie_data_util.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/viewmodel/movie_list_view_model.dart';

import 'detail/movie_top_list_item_view.dart';

/// 电影榜单列表
class MovieTopListView extends StatefulWidget {
  final String action;
  final String title;
  final String subTitle;
  final String image;

  MovieTopListView(this.title, this.subTitle, this.image, this.action);

  @override
  State<StatefulWidget> createState() {
    return new MovieTopListViewState();
  }
}

class MovieTopListViewState extends State<MovieTopListView> with RouteAware {
  int start;
  int count;

  /// 是否还有更多
  bool _loadMore = false;

  /// 是否是刷新
  bool _refresh = false;
  bool isVisible = true;

  /// 列表数据
  List<MovieItem> topMovieData = [];

  ScrollController _scrollController = new ScrollController();

  double navAlpha = 0;

  @override
  void initState() {
    start = 0;
    count = 20;
    super.initState();
  }

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

      var offset = _scrollController.offset;
      if (offset < 0 && navAlpha != 0) {
        setState(() {
          navAlpha = 0;
        });
      } else if (offset < 50) {
        setState(() {
          double temp = 1 - (50 - offset) * 1.0 / 50;
          if (temp > 1) {
            navAlpha = 1;
          } else if (temp < 0) {
            navAlpha = 0;
          } else {
            navAlpha = temp;
          }
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  Future<dynamic> loadData(MovieListViewModel model,
      {isRefresh = false}) async {
    var list;
    _refresh = isRefresh;
    switch (widget.action) {
      case 'weekly':
        list = await model.getWeeklyList();
        break;
      case 'top250':
        list = await model.getTop250List(start: start, count: count);
        break;
      case 'new_movies':
        list = await model.getNewMoviesList();
        break;
      case 'usBox':
        list = await model.getUsBoxList();
        break;
    }
    var newMovie = MovieDataUtil.getMovieList(list);
    if (newMovie != null && newMovie.length > 0) {
      if (isRefresh) {
        topMovieData.clear();
        topMovieData.addAll(newMovie);
        _refresh = false;
      } else {
        _loadMore = true;
        topMovieData.addAll(newMovie);
        start = start + count;
      }
    } else {
      _loadMore = false;
      model.isLoadMore = false;
    }
    if (widget.action != 'top250') {
      _loadMore = false;
    }
    if (topMovieData.isEmpty) {
      model.setEmpty();
    } else {
      model.setSuccess();
    }
  }

  Future<void> refreshData({MovieListViewModel model}) async {
    start = 0;
    await Future.delayed(Duration(milliseconds: 1000), () {
      loadData(model, isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isVisible) {
      updateStatusBar();
    }
    return ProviderWidget<MovieListViewModel, MovieRepository>(
        model: new MovieListViewModel(),
        initData: (model) {
          loadData(model);
          addListener(model);
        },
        builder: (context, model, child) {
          if (!model.isSuccessShowDataState()) {
            return new CommonViewStateHelper(
                model: model,
                onErrorPressed: () {
                  loadData(model);
                },
                onEmptyPressed: () {
                  loadData(model);
                });
          }
          return Scaffold(
            body: Scaffold(
              body: Stack(
                children: <Widget>[
                  RefreshIndicator(
                      child: ListView(
                        padding: const EdgeInsets.only(top: 0),
                        controller: _scrollController,
                        children: <Widget>[
                          MovieTopHeadView(
                              widget.title, widget.subTitle, widget.image),
                          _buildMovieItem(),
                        ],
                      ),
                      onRefresh: () {
                        return refreshData(model: model);
                      }),
                  CommonTitleView(
                    widget.title,
                    navAlpha,
                    localImg: 'images/icon_arrow_back_black.png',
                    titleColor: AppColor.black,
                  )
                ],
              ),
            ),
          );
        });
  }

  /// 电影列表条目
  Widget _buildMovieItem() {
    List<Widget> childrens = [];
    int index = 0;
    for (MovieItem item in topMovieData) {
      childrens.add(MovieTopListItemView(item, ++index));
    }
    if (_loadMore) {
      childrens.add(new Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ));
    }
    return Column(
      children: childrens,
    );
  }

  @override
  void didPush() {
    // 间隔500毫秒后，再设置状态栏样式。否则设置无效（会被build覆盖？）。
    Timer(Duration(milliseconds: 500), () {
      updateStatusBar();
    });
  }

  @override
  void didPopNext() {
    isVisible = true;
    updateStatusBar();
  }

  @override
  void didPop() {
    isVisible = false;
  }

  @override
  void didPushNext() {
    isVisible = false;
  }

  /// 更新状态栏
  updateStatusBar() {
    if (navAlpha == 1) {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    } else {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    }
  }
}
