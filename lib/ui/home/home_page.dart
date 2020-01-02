import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';

import 'home_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Text(
          '首页',
          style: TextStyle(fontSize: 18, color: AppColor.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: AppColor.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: HomeListView(),
    );
  }
}
