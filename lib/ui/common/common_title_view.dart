import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:provider_mvvm/common/app_color.dart';
import 'package:provider_mvvm/utils/screen_util.dart';

/// 通用标题View
class CommonTitleView extends StatelessWidget {
  final double navAlpha;
  final String title;
  final Color pageColor;
  final String localImg;
  final Color titleColor;

  CommonTitleView(this.title, this.navAlpha,
      {this.pageColor, this.localImg, this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 44,
          height: ScreenUtil.navigationBarHeight,
          padding: EdgeInsets.only(left: 15, top: ScreenUtil.topSafeHeight),
          child: GestureDetector(
            onTap: () {
              AppNavigator.back(context);
            },
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.only(left: 15, top: ScreenUtil.topSafeHeight),
            decoration: BoxDecoration(color: pageColor ?? AppColor.white),
            width: ScreenUtil.width,
            height: ScreenUtil.navigationBarHeight,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    AppNavigator.back(context);
                  },
                  child: Image.asset(
                      localImg ?? 'images/icon_arrow_back_white.png'),
                ),
                Expanded(
                    child: Text(title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: titleColor ?? AppColor.white))),
              ],
            ),
          ),
        )
      ],
    );
  }
}
