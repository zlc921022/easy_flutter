import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/repository/actor_repository.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_head.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_photo.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_works.dart';
import 'package:flutter_movie/ui/common/common_intro_view.dart';
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
  String intro = '关关雎洲，在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好逑在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好';

  @override
  Widget build(BuildContext context) {

    return ProviderWidget<ActorViewModel, ActorRepository>(
        model: ActorViewModel(),
        initData: (model) {
          model.getActorDetail(widget.actorId);
        },
        builder: (context, model, child) {
          if (model.actorDetail == null) {
            return Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          return Scaffold(
              backgroundColor: Color(0x8800ff00),
              body: Stack(
                children: <Widget>[
                  new ListView(
                    children: <Widget>[
                      new ActorDetailHead(model.actorDetail),
                      new CommonIntroView(model.actorDetail.summary, expand, clickShowAll),
                      new ActorDetailWorks(model.actorDetail.works),
                      new ActorPhotoView(model.actorDetail.photos),
                    ],
                  ),
                  //  CommonTitleView('测试'),
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
