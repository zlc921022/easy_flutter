import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';

/// 通用头部AppBar
class CommonAppBar extends AppBar {

  final BuildContext context;
  final String mTitle;
  final List<Widget> mActions;
  final bool isShowLeading;

  CommonAppBar(this.context, this.mTitle,
      {this.mActions, this.isShowLeading = true});

  /// 背景颜色
  @override
  Color get backgroundColor => AppColor.white;

  /// 返回图片
  @override
  Widget get leading => isShowLeading
      ? GestureDetector(
          onTap: () {
            AppNavigator.back(context);
          },
          child: Image.asset('images/icon_arrow_back_black.png'),
        )
      : super.leading;

  /// 标题
  @override
  Widget get title => Text(
        mTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16, color: AppColor.black),
      );

  /// 右侧actions
  @override
  List<Widget> get actions => mActions;
}
