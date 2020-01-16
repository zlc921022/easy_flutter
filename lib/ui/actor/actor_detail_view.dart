import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_actor_detail.dart';
import 'package:flutter_movie/repository/actor_repository.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_head.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_photo.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_works.dart';
import 'package:flutter_movie/ui/common/common_intro_view.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';
import 'package:flutter_movie/viewmodel/actor_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider_mvvm/base/provider_widget.dart';
import 'package:provider_mvvm/base/view_state_widget.dart';
import 'package:provider_mvvm/common/app_color.dart';

/// 演员详情View
class ActorDetailView extends StatefulWidget {
  final String actorId;

  ActorDetailView(this.actorId);

  @override
  State<StatefulWidget> createState() {
    return ActorDetailViewState();
  }
}

class ActorDetailViewState extends State<ActorDetailView> {
  bool expand = false;

  /// 透明度
  double navAlpha = 0;

  /// listView滑动监听
  ScrollController scrollController = new ScrollController();

  /// 接口返回相关数据
  MovieActorDetail actorDetail;
  Color pageColor = AppColor.white;

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
          double temp = 1 - (50 - offset) * 1.0 / 50;
          if (temp > 1) {
            navAlpha = 1;
          } else if (temp < 0) {
            navAlpha = 0;
          } else {
            navAlpha = temp;
          }
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
    return ProviderWidget<ActorViewModel, ActorRepository>(
        model: ActorViewModel(),
        initData: (model) {
          loadData(model);
        },
        builder: (context, model, child) {
          if (!model.isSuccess()) {
            return CommonViewStateHelper(
                model: model,
                onEmptyPressed: () {
                  loadData(model);
                },
                onErrorPressed: () {
                  loadData(model);
                });
          }
          return Scaffold(
              backgroundColor: pageColor,
              body: Stack(
                children: <Widget>[
                  new ListView(
                    controller: scrollController,
                    children: <Widget>[
                      new ActorDetailHead(actorDetail),
                      new CommonIntroView(
                          actorDetail.summary, expand, clickShowAll),
                      new ActorDetailWorks(actorDetail.works),
                      new ActorPhotoView(actorDetail.photos, actorDetail.id),
                    ],
                  ),
                  CommonTitleView(actorDetail.name, navAlpha,
                      pageColor: pageColor),
                ],
              ));
        });
  }

  /// 数据加载处理
  Future<dynamic> loadData(ActorViewModel model) async {
    var data = await model.getActorDetail(widget.actorId);
    if (data != null) {
      actorDetail = MovieActorDetail.fromJson(data);
    }
    PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(actorDetail?.avatars?.small),
    );
    if (generator.darkMutedColor != null) {
      pageColor = generator.darkMutedColor.color;
    } else {
      pageColor = Color(0xff35374c);
    }
    if (actorDetail == null) {
      model.setEmpty();
    } else {
      model.setSuccess();
    }
  }

  void clickShowAll() {
    setState(() {
      expand = !expand;
    });
  }
}
