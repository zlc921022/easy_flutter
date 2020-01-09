import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/home_section_title.dart';
import 'package:flutter_movie/ui/home/top_list_item_view.dart';
import 'package:flutter_movie/viewmodel/movie_view_model.dart';

class HomeTopMovieList extends StatefulWidget {
  HomeTopMovieList();

  @override
  State<StatefulWidget> createState() {
    return new HomeTopMovieListState();
  }
}

class HomeTopMovieListState extends State<HomeTopMovieList> with AutomaticKeepAliveClientMixin<HomeTopMovieList>{
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieViewModel, MovieRepository>(
        model: new MovieViewModel(),
        initData: (model) {
          model.loadData(start : 0, count : 10);
        },
        builder: (context, model, child) {
          if (model.banners == null) {
            return CupertinoActivityIndicator();
          }
          return Container(
            color: AppColor.white,
            margin: const EdgeInsets.only(bottom: 20),
            child: new Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    HomeSectionTitle('电影榜单'),
                  ],
                ),
                SizedBox(height: 12),
                CarouselSlider.builder(
                  // banner所占屏幕比例
                  viewportFraction: 0.8,
                  itemCount: model.banners.length,
                  itemBuilder: (context, index) {
                    var banner = model.banners[index];
                    return new TopListItemView(banner);
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
