import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';

class APP extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text('测试标题'),
        ),
        body: new CommonTitleView('测试'),
      ),
    );
  }

}