import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/app.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/repository/home_respository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/viewmodel/home_view_model.dart';

void main() {
  runApp(App());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //把上面的注释，打开下面的注释即可切换查看效果
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel, HomeRepository>(
        model: HomeViewModel(),
        initData: (model) {
          model.loadData(start: 0, count: 20);
        },
        builder: (context, model, child) {
          if (model.comingData == null) {
            return Container(
              color: AppColor.white,
              child: CupertinoActivityIndicator(),
            );
          } else {
            return Scaffold(
              backgroundColor: AppColor.white,
              body: new Center(child: Text('请求成功')),
            );
          }
        });
  }
}
