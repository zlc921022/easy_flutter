import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_intro_view.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_cast.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_channel.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_comment.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_head.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_prevue.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/viewmodel/movie_view_model.dart';

/// 电影详情
class MovieDetailList extends StatefulWidget {
  final String movieId;

  MovieDetailList(this.movieId);

  @override
  State<StatefulWidget> createState() {
    return new MovieDetailListState();
  }
}

class MovieDetailListState extends State<MovieDetailList> {
  bool expand = false;
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var offset = scrollController.offset;
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

  @override
  Widget build(BuildContext context) {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    return ProviderWidget<MovieViewModel, MovieRepository>(
        model: MovieViewModel(),
        initData: (model) {
          model.getMovieDetail(widget.movieId);
        },
        builder: (context, model, child) {
          if (model.movieDetail == null ||
              model.movieDetailPageColor == AppColor.white) {
            return Scaffold(
              body: new Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          return Scaffold(
              backgroundColor: model.movieDetailPageColor,
              body: Stack(
                children: <Widget>[
                  ListView(
                    controller: scrollController,
                    children: <Widget>[
                      new MovieDetailHead(model.movieDetail,
                          model.movieDetailPageColor, navAlpha),
                      new MovieDetailChannel(model.movieDetail.tags),
                      new CommonIntroView(
                          model.movieDetail.summary, expand, clickShowAll),
                      new MovieDetailCast(
                          model.movieDetail.directors, model.movieDetail.casts),
                      new MovieDetailPrevue(model.movieDetail.trailers,
                          model.movieDetail.photos, model.movieDetail.id,
                          title: model.movieDetail.title),
                      new MovieDetailComment(model.movieDetail.comments),
                    ],
                  ),
                  CommonTitleView(model.movieDetail.title, navAlpha,
                      pageColor: model.movieDetailPageColor),
                ],
              ));
        });
  }

  void clickShowAll() {
    setState(() {
      expand = !expand;
    });
  }
}
