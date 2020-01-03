import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:widget_chain/widget_chain.dart';

class MyHeadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: Screen.width,
      height: 188,
      color: AppColor.black_cc,
      child: Text('我是头部').intoCenter(),
    );
  }
}
