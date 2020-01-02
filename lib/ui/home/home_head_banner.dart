import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../util/screen.dart';

class HomeHeadBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: AppColor.white,
      width: Screen.width,
      margin: const EdgeInsets.only(bottom: 5),
      height: 120,
      child: Text(
        '我是头部',
        style: TextStyle(fontWeight: FontWeight.bold),
      ).intoCenter(),
    );
  }
}
