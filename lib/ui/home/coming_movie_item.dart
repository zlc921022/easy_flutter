import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../util/screen.dart';

class ComingMovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
//        CommonRoundedImage(''),
        SizedBox(height: 5),
        Text('美丽人生',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.black,
                fontSize: 14)),
        SizedBox(height: 5),
        Text('10000人想看',
            style: TextStyle(fontSize: 12, color: AppColor.black_99)),
        SizedBox(height: 5),
        Text('1月3日', style: TextStyle(fontSize: 10, color: AppColor.red)),
      ],
    ).intoContainer(width: 120,height: 120);
  }
}
