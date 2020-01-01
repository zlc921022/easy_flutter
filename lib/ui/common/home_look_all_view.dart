import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:widget_chain/widget_chain.dart';

class HomeLookAllView extends StatelessWidget {

  GestureTapCallback _callback;
  HomeLookAllView(this._callback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _callback();
      },
      child: Row(
        children: <Widget>[
          Text('全部', style: TextStyle(fontSize: 14, color: AppColor.black),),
          SizedBox(width: 6),
          Icon(Icons.arrow_forward_ios)
        ],
      ).intoContainer(margin: EdgeInsets.only(right: 15, top: 15)),
    );
  }
}