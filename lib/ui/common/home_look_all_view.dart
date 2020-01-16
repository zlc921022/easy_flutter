import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvvm/common/app_color.dart';

/// 查看全部组件
class HomeLookAllView extends StatelessWidget {
  final GestureTapCallback _callback;

  HomeLookAllView(this._callback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _callback();
      },
      child: Container(
        height: 42,
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              '全部',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColor.black),
            ),
            SizedBox(width: 6),
            Icon(
              CupertinoIcons.forward,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
