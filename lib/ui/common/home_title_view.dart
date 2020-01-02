import 'package:flutter/material.dart';
import 'package:widget_chain/widget_chain.dart';

import 'app_color.dart';

class HomeTitleView extends StatelessWidget {
  final String title;

  HomeTitleView(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.black),
        ),
        SizedBox(height: 6),
        Container(
          height: 2,
          color: AppColor.black,
        )
      ],
    ).intoContainer(margin: const EdgeInsets.only(left: 12, top: 10));
  }
}
