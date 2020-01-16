import 'package:flutter/material.dart';
import 'package:provider_mvvm/common/app_color.dart';


/// 首页章节标题
class HomeSectionTitle extends StatelessWidget {
  final String title;

  HomeSectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColor.black),
          ),
          SizedBox(height: 5),
          Container(
            width: 70,
            height: 2,
            color: AppColor.black,
          )
        ],
      ),
    );
  }
}
