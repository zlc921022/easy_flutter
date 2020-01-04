import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/movie/detail/movie_detail_head.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        new ListView(
          children: <Widget>[
            new MovieDetailHead(imageUrl),
//        new MovieDetailChannel(),
//        new MovieDetailIntro(),
//        new MovieDetailCast(),
//        new MovieDetailPrevue(),
//        new MovieDetailComment()
          ],
        ),
        //  CommonTitleView('测试'),
      ],
    ));
  }
}
