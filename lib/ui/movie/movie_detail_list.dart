import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/common_intro_view.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_cast.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_channel.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_comment.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_head.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_prevue.dart';

class MovieDetailList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
    return Scaffold(
        backgroundColor: Color(0x8800ff00),
        body: Stack(
          children: <Widget>[
            new ListView(
              children: <Widget>[
                new MovieDetailHead(imageUrl),
                new MovieDetailChannel(),
                new CommonIntroView(intro, expand, clickShowAll),
                new MovieDetailCast(),
                new MovieDetailPrevue(),
                new MovieDetailComment(),
              ],
            ),
            //  CommonTitleView('测试'),
          ],
        ));
  }

  void clickShowAll() {
    setState(() {
      expand = !expand;
    });
  }
}
