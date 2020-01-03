import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:widget_chain/widget_chain.dart';

class CommonMyItemView extends StatelessWidget {
  final String icon;
  final String title;
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
            Row(
              children: <Widget>[
                Image.asset('images/$icon',width: 26,height: 26),
                SizedBox(width: 15),
                Text(title,
                        style:
                            TextStyle(color: AppColor.black_33, fontSize: 14))
                    .intoExpanded(),
                Image.asset('images/icon_arrow_forward.png',
                    width: 20, height: 20),
              ],
            ).intoContainer(
              margin: const EdgeInsets.fromLTRB(10, 15, 15, 15),
            ),
            Divider(
              height: 1,
              color: AppColor.black_cc,
            ).intoContainer(
              margin: const EdgeInsets.symmetric(horizontal: 5),
            )
          ],
        ));
  }
}
