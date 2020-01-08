import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_my_item_view.dart';
import 'package:flutter_movie/ui/my/my_head_image.dart';
import 'package:flutter_movie/util/toast.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyPageState();
  }
}

class MyPageState extends State<MyPage> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.white,
        child: ListView(
          children: <Widget>[
            MyHeadImage(),
            CommonMyItemView('icon_github.png', '项目地址', clickProject),
            CommonMyItemView('icon_qq.png', 'Flutter技术群', clickQQChat),
            CommonMyItemView('icon_wechat.png', '我的微信号', clickWeChat),
            CommonMyItemView('icon_account.png', '我的公众号', clickAccount),
            CommonMyItemView('icon_api.png', 'API文档', clickApi),
          ],
        ),
      ),
    );
  }

  // 项目地址
  void clickProject() {
    String url = 'https://github.com/zlc921022/flutter_movie';
    AppNavigator.pushWebView(context, url: url, title: '项目地址');
  }

  // 技术交流
  void clickQQChat() {
    Clipboard.setData(ClipboardData(text: '1509815887'));
    Toast.show('qq已拷贝');
  }

  // 微信
  void clickWeChat() {
    Clipboard.setData(ClipboardData(text: '1509815887'));
    Toast.show('微信已拷贝');
  }

// 我的公众号
  void clickAccount() {
    Clipboard.setData(ClipboardData(text: '1509815887'));
    Toast.show('公众号已拷贝');
  }

// API文档
  void clickApi() {
    String url = 'https://github.com/Mayandev/morec/blob/master/API.md';
    AppNavigator.pushWebView(context, url: url, title: 'API文档');
  }
}
