import 'package:flutter/material.dart';
import 'package:provider_mvvm/common/app_color.dart';

/// bannner 小圆点集合
class BannerCirclePoint extends StatelessWidget {
  final bool _isSelected;
  BannerCirclePoint(this._isSelected);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isSelected
              ? AppColor.white
              : AppColor.black_99),
    );
  }
}
