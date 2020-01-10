import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/base/view_state_widget.dart';
import 'package:flutter_movie/model/movie_detail.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_intro_view.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_cast.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_channel.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_comment.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_head.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_trailer.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/viewmodel/movie_view_model.dart';
import 'package:palette_generator/palette_generator.dart';

/// 电影详情
class MovieDetailView extends StatefulWidget {
  final String movieId;

  MovieDetailView(this.movieId);

  @override
  State<StatefulWidget> createState() {
    return new MovieDetailViewState();
  }
}

class MovieDetailViewState extends State<MovieDetailView> {
  bool expand = false;
  ScrollController _scrollController = ScrollController();
  double navAlpha = 0;
  MovieDetail movieDetail;
  Color pageColor = AppColor.white;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
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

  @override
  Widget build(BuildContext context) {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    return ProviderWidget<MovieViewModel, MovieRepository>(
        model: MovieViewModel(),
        initData: (model) {
          loadData(model);
        },
        builder: (context, model, child) {
          if (!model.isSuccess()) {
            return CommonViewStateHelper(
                model: model,
                onErrorPressed: () {
                  loadData(model);
                },
                onEmptyPressed: () {
                  loadData(model);
                });
          }
          return Scaffold(
              backgroundColor: pageColor,
              body: Stack(
                children: <Widget>[
                  ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      new MovieDetailHead(movieDetail, pageColor, navAlpha),
                      new MovieDetailChannel(movieDetail.tags),
                      new CommonIntroView(
                          movieDetail.summary, expand, clickShowAll),
                      new MovieDetailCast(
                          movieDetail.directors, movieDetail.casts),
                      new MovieDetailTrailer(movieDetail.trailers,
                          movieDetail.photos, movieDetail.id,
                          title: movieDetail.title),
                      new MovieDetailComment(movieDetail.comments),
                    ],
                  ),
                  CommonTitleView(movieDetail.title, navAlpha,
                      pageColor: pageColor),
                ],
              ));
        });
  }

  void clickShowAll() {
    setState(() {
      expand = !expand;
    });
  }

  Future<dynamic> loadData(MovieViewModel model) async {
    var data = await model.getMovieDetail(widget.movieId);
    if (data != null) {
      movieDetail = MovieDetail.fromJson(data);
    }
    PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(movieDetail.images.small),
    );
    if (generator.darkVibrantColor != null) {
      pageColor = generator.darkVibrantColor.color;
    } else {
      pageColor = Color(0xff35374c);
    }
    if (movieDetail == null) {
      model.setEmpty();
    } else {
      model.setSuccess();
    }
  }
}
