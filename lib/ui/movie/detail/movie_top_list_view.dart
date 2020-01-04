import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/movie/detail/movie_top_head_view.dart';

import 'movie_top_list_item_view.dart';

class MovieTopListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MovieTopListViewState();
  }
}

class MovieTopListViewState extends State<MovieTopListView> {
  String imageUrl =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578164916435&di=34eedc1ed57f6457a8dd39917191e37e&imgtype=0&src=http%3A%2F%2Fp4.ssl.cdn.btime.com%2Ft01790a9db7a1c72200.jpg%3Fsize%3D640x1025";

  List<Widget> getData() {
    List<Widget> data = [];
    data.add(MovieTopHeadView());
    for (int i = 0; i < 7; i++) {
      data.add(MovieTopListItemView(imageUrl));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: getData(),
      ),
    );
  }
}
