import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';
import 'package:flutter_movie/ui/movie/detail/movie_list_item_view.dart';

class MovieListView extends StatefulWidget {
  String imageUrl =
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578135199158&di=2d7c66c3923b480937e7033a198ce527&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201512%2F29%2F20151229114315_TNwtx.thumb.700_0.jpeg';
  String action;
  String title;

  MovieListView(this.action, this.title);

  @override
  State<StatefulWidget> createState() {
    return new MovieListViewState();
  }
}

class MovieListViewState extends State<MovieListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, this.widget.title),
      body: Container(
          color: AppColor.white,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 16,
              itemBuilder: (context, index) {
                return new MovieListItemView(
                    this.widget.imageUrl, this.widget.action);
              })),
    );
  }
}
