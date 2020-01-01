import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:widget_chain/widget_chain.dart';

class CommonTitleView extends StatelessWidget {
  final String title;

  CommonTitleView(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          child: GestureDetector(
            onTap: () {
              AppNavigator.back(context);
            },
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: AppColor.white),
        ).intoExpanded()
      ],
    ).intoContainer(
        padding: EdgeInsets.only(bottom: 10, top: 10, right: 22),
        color: AppColor.blue,
        height: 60);
  }
}
