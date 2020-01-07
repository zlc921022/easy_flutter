import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';

class CommonAppBar extends AppBar {
  final BuildContext context;
  final String mTitle;
  final List<Widget> mActions;
  final bool isShowLeading;

  CommonAppBar(this.context, this.mTitle,
      {this.mActions, this.isShowLeading = true});

  @override
  Color get backgroundColor => AppColor.white;

  @override
  Widget get leading => isShowLeading
      ? GestureDetector(
          onTap: () {
            AppNavigator.back(context);
          },
          child: Image.asset('images/icon_arrow_back_black.png'),
        )
      : super.leading;

  @override
  Widget get title => Text(
        mTitle,
        style: TextStyle(fontSize: 16, color: AppColor.black),
      );

  @override
  List<Widget> get actions => mActions;
}
