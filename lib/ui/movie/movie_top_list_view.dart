import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/movie/detail/movie_top_head_view.dart';
import 'package:flutter_movie/util/movie_data_util.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/viewmodel/movie_list_view_model.dart';

import 'detail/movie_top_list_item_view.dart';

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

class MovieTopListViewState extends State<MovieTopListView> {
  int start;
  int count;

  /// 是否还有更多
  bool _loadMore = false;

  /// 列表数据
  List<MovieItem> topMovieData = [];

  ScrollController _scrollController = new ScrollController();

  double navAlpha = 0;

  @override
  void initState() {
    // TODO: implement initState
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
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  Future<dynamic> loadData(MovieListViewModel model) async {
    var list;
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
    if (newMovie != null || newMovie.length != 0) {
      _loadMore = true;
      topMovieData.addAll(newMovie);
      start = start + count;
    } else {
      _loadMore = false;
    }
    if (widget.action != 'top250') {
      _loadMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieListViewModel, MovieRepository>(
        model: new MovieListViewModel(),
        initData: (model) {
          loadData(model);
          addListener(model);
        },
        builder: (context, model, child) {
          if (topMovieData.length == 0) {
            return Scaffold(
              body: new Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          return Scaffold(
            body: Scaffold(
              body: Stack(
                children: <Widget>[
                  ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      MovieTopHeadView(
                          widget.title, widget.subTitle, widget.image),
                      _buildMovieItem(),
                    ],
                  ),
                  _buildNavigationBar(widget.title)
                ],
              ),
            ),
          );
        });
  }

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


  Widget _buildNavigationBar(String title) {
    return Stack(
      children: <Widget>[
        Container(
          width: 44,
          height: Screen.navigationBarHeight,
          padding: EdgeInsets.only(left: 15, top: Screen.topSafeHeight),
          child: GestureDetector(
            onTap: () {
              AppNavigator.back(context);
            },
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.only(left: 15, top: Screen.topSafeHeight),
            decoration: BoxDecoration(color: AppColor.white),
            width: Screen.width,
            height: Screen.navigationBarHeight,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    AppNavigator.back(context);
                  },
                  child: Image.asset('images/icon_arrow_back_black.png'),
                ),
                Expanded(
                    child: Text(title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.black))),

              ],
            ),
          ),
        )
      ],
    );
  }
}
