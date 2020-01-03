import 'package:flutter/material.dart';

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
              ? Color.fromRGBO(0, 0, 0, 0.9)
              : Color.fromRGBO(0, 0, 0, 0.4)),
    );
  }
}
