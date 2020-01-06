import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/app.dart';
import 'package:flutter_movie/base/view_model_provider.dart';
import 'package:flutter_movie/viewmodel/home_view_model.dart';

void main() {
  runApp(MyApp());
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
      home: ViewModelProvider(
        viewModel: new HomeViewModel(),
        child: TestPage(),
      ),
    );
  }
}

class TestPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new TestPageState();
  }

}

class TestPageState extends State<TestPage>{

  HomeViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = ViewModelProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                viewModel.getComingList(start: 0,count: 20);
              },
              child: Text('点击测试'),
            )
          ],
        ),
      ),
    );
  }
}

