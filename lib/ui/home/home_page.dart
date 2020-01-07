import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/repository/home_respository.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/viewmodel/home_view_model.dart';

import 'home_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel, HomeRepository>(
        model: HomeViewModel(),
        initData: (model) {
          model.loadData(start: 0, count: 6);
        },
        builder: (context, model, child) {
          if (model.comingData == null) {
            return new Scaffold(
              backgroundColor: AppColor.white,
              body: CupertinoActivityIndicator()
            );
          }
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
            body: HomeListView(model),
          );
        });
  }
}
