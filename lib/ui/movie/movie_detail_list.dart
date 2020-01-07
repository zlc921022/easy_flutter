import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/ui/common/common_intro_view.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_cast.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_channel.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_comment.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_head.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_prevue.dart';
import 'package:flutter_movie/viewmodel/movie_view_model.dart';

class MovieDetailList extends StatefulWidget {

  String movieId;
  MovieDetailList(this.movieId);

  @override
  State<StatefulWidget> createState() {
    return new MovieDetailListState();
  }
}

class MovieDetailListState extends State<MovieDetailList> {
  String imageUrl =
      "http://img.jdzj.com/UserDocument/2012Y/yldsfk/Picture/20121215114020.jpg";

  bool expand = false;
  String intro = '关关雎洲，在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好逑在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好';

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieViewModel, MovieRepository>(
        model: MovieViewModel(),
        initData: (model){
          model.getMovieDetail(widget.movieId);
        },
        builder: (context, model, child) {
          if(model.movieDetail == null){
            return Scaffold(
              body: new Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          return  Scaffold(
              backgroundColor: Color(0x8800ff00),
              body: Stack(
                children: <Widget>[
                  new ListView(
                    children: <Widget>[
                      new MovieDetailHead(model.movieDetail),
                      new MovieDetailChannel(model.movieDetail.tags),
                      new CommonIntroView(model.movieDetail.summary, expand, clickShowAll),
                      new MovieDetailCast(model.movieDetail.directors,model.movieDetail.casts),
                      new MovieDetailPrevue(model.movieDetail.trailers,model.movieDetail.photos,model.movieDetail.id),
                      new MovieDetailComment(model.movieDetail.comments),
                    ],
                  ),
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
