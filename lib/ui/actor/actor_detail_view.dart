import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/repository/actor_repository.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_head.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_photo.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_works.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_intro_view.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/viewmodel/actor_view_model.dart';

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
  double navAlpha  = 0;

  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener((){
      var offset = scrollController.offset;
      if(offset < 0 && navAlpha != 0){
        setState(() {
          navAlpha = 0;
        });
      }else if(offset < 50){
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      }else if(navAlpha != 1){
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    return ProviderWidget<ActorViewModel, ActorRepository>(
        model: ActorViewModel(),
        initData: (model) {
          model.getActorDetail(widget.actorId);
        },
        builder: (context, model, child) {
          if (model.actorDetail == null || model.actorDetailPageColor == AppColor.white) {
            return Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          return Scaffold(
              backgroundColor: model.actorDetailPageColor,
              body: Stack(
                children: <Widget>[
                  new ListView(
                    controller: scrollController,
                    children: <Widget>[
                      new ActorDetailHead(model.actorDetail),
                      new CommonIntroView(model.actorDetail.summary, expand, clickShowAll),
                      new ActorDetailWorks(model.actorDetail.works),
                      new ActorPhotoView(model.actorDetail.photos,model.actorDetail.id),
                    ],
                  ),
                  _buildNavigationBar(model.actorDetail.name, model.actorDetailPageColor),
                  //  CommonTitleView('测试'),
                ],
              ));
        });
  }

  Widget _buildNavigationBar(String title, Color pageColor) {
    return Stack(
      children: <Widget>[
        Container(
          width: 44,
          height: Screen.navigationBarHeight,
          padding: EdgeInsets.only(left: 15, top: Screen.topSafeHeight),
          child: GestureDetector(
            onTap: () {
              AppNavigator.back(context);
            },
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.only(left: 15, top: Screen.topSafeHeight),
            decoration: BoxDecoration(color: pageColor),
            width: Screen.width,
            height: Screen.navigationBarHeight,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    AppNavigator.back(context);
                  },
                  child: Image.asset('images/icon_arrow_back_white.png'),
                ),
                Expanded(
                    child: Text(title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white))),

              ],
            ),
          ),
        )
      ],
    );
  }

  void clickShowAll() {
    setState(() {
      expand = !expand;
    });
  }
}
