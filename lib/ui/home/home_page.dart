import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/common_app_bar.dart';
import 'package:flutter_movie/ui/home/home_list_view.dart';
import 'package:provider_mvvm/common/app_color.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CommonAppBar(
        context,
        '首页',
        isShowLeading: false,
        isElevation: false,
        mActions: <Widget>[
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
