import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';
import 'package:flutter_movie/ui/movie/detail/movie_list_item_view.dart';
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
  int start = 0;
  int count = 20;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieListViewModel, MovieRepository>(
        model: MovieListViewModel(),
        initData: (model) {
          if (widget.action == 'coming_soon') {
            model.getComingList(start: start, count: count);
          } else if (widget.action == 'top_movie') {
            model.getNowPlayingList(start: start, count: count);
          }
        },
        builder: (context, model, child) {
          if (model.movieData == null) {
            return Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: CommonAppBar(context, this.widget.title),
            body: Container(
                color: AppColor.white,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.movieData.length,
                    itemBuilder: (context, index) {
                      MovieItem movieItem = model.movieData[index];
                      return new MovieListItemView(
                          movieItem, this.widget.action);
                    })),
          );
        });
  }
}
