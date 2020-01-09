import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/model/movie_banner.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/repository/home_respository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_app_bar.dart';
import 'package:flutter_movie/ui/home/home_coming_movie.dart';
import 'package:flutter_movie/ui/home/home_head_banner.dart';
import 'package:flutter_movie/ui/home/home_top_movie.dart';
import 'package:flutter_movie/ui/home/home_top_movie_list.dart';
import 'package:flutter_movie/util/movie_data_util.dart';
import 'package:flutter_movie/viewmodel/home_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsBanner> newsBannerData;
  List<MovieItem> comingData;
  List<MovieItem> nowPlayData;
  int start = 0;
  int count = 6;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel, HomeRepository>(
        model: HomeViewModel(),
        initData: (model) {
          loadData(model);
        },
        builder: (context, model, child) {
          if (comingData == null) {
            return new Scaffold(
                backgroundColor: AppColor.white,
                body: new Center(
                  child: CupertinoActivityIndicator(),
                ));
          }
          return new Scaffold(
              appBar: CommonAppBar(
                context,
                '首页',
                isShowLeading: false,
                isElevation: false,
                mActions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: AppColor.black,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              body: new ListView(
                addAutomaticKeepAlives: true,
                cacheExtent: 10 * 1000.0,
                children: <Widget>[
                  new HomeHeadBanner(newsBannerData),
                  new HomeTopMovie(nowPlayData),
                  new HomeComingMovie(comingData),
                  new HomeTopMovieList(),
                ],
              ));
        });
  }

  /// 加载数据
  Future<dynamic> loadData(HomeViewModel model) async {
    var newsList = await model.getNewsList();
    var nowPlaylist = await model.getNowPlayingList(start: start, count: count);
    var comingList = await model.getComingList(start: start, count: count);
    this.newsBannerData = _news2Banner(newsList);
    this.comingData = MovieDataUtil.getMovieList(comingList);
    this.nowPlayData = MovieDataUtil.getMovieList(nowPlaylist);
  }

  List<NewsBanner> _news2Banner(var list) {
    List content = list;
    List<NewsBanner> banners = [];
    content.forEach((data) {
      banners.add(NewsBanner(data));
    });
    return banners;
  }
}
