import 'package:flutter/material.dart';
import 'package:provider_mvvm/common/app_color.dart';

/// 通用我的页面itemView
class CommonMyItemView extends StatelessWidget {
  final String icon;
  final String title;

  // 点击事件回调
  final GestureTapCallback callback;

  CommonMyItemView(this.icon, this.title, this.callback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          callback();
        },
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 15, 15),
              child: Row(
                children: <Widget>[
                  Image.asset('images/$icon', width: 26, height: 26),
                  SizedBox(width: 15),
                  Expanded(
                      child: Text(title,
                          style: TextStyle(
                              color: AppColor.black_33, fontSize: 14))),
                  Image.asset('images/icon_arrow_forward.png',
                      width: 20, height: 20),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Divider(
                height: 1,
                color: AppColor.black_cc,
              ),
            ),
          ],
        ));
  }
}
