import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_head.dart';
import 'package:flutter_movie/ui/actor/detail/actor_detail_photo.dart';
import 'package:flutter_movie/ui/actor/detail/actor_works_view.dart';
import 'package:flutter_movie/ui/common/common_intro_view.dart';

class ActorDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActorDetailViewState();
  }
}

class ActorDetailViewState extends State {
  bool expand = false;
  String intro = '关关雎洲，在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好逑在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好在河之洲，窈窕淑女，君子好逑,关关雎洲，'
      '在河之洲，窈窕淑女，君子好逑,关关雎洲，在河之洲，窈窕淑女，君子好';

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578135199158&di=2d7c66c3923b480937e7033a198ce527&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201512%2F29%2F20151229114315_TNwtx.thumb.700_0.jpeg';

    return Scaffold(
        backgroundColor: Color(0x8800ff00),
        body: Stack(
          children: <Widget>[
            new ListView(
              children: <Widget>[
                new ActorDetailHead(imageUrl, '于和伟'),
                new CommonIntroView(intro, expand, clickShowAll),
                new ActorWorksView(),
                new ActorPhotoView(),
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
