import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_my_item_view.dart';
import 'package:flutter_movie/ui/my/my_head_image.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: ListView(
        children: <Widget>[
          MyHeadImage(),
          CommonMyItemView('icon_github.png','项目地址',clickProject),
          CommonMyItemView('icon_qq.png','Flutter技术群',clickQQChat),
          CommonMyItemView('icon_wechat.png','我的微信号',clickWeChat),
          CommonMyItemView('icon_account.png','我的公众号',clickAccount),
          CommonMyItemView('icon_api.png','API文档',clickApi),
        ],
      ),
    );
  }
}

// 项目地址
void clickProject(){

}

// 技术交流
void clickQQChat(){

}

// 微信
void clickWeChat(){

}

// 我的公众号
void clickAccount(){

}

// API文档
void clickApi(){

}
