import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/home/home_page.dart';
import 'package:flutter_movie/ui/my/my_page.dart';

/// app首页
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AppState();
  }
}

class AppState extends State<App> {

  int _currentIndex = 0;

  /// 未选中的图片
  var _tabImages = [
    'images/tab_home.png',
    'images/tab_my.png',
  ];

  /// 选中的图片
  var _tabSelectedImages = [
    'images/tab_home_selected.png',
    'images/tab_my_selected.png'
  ];

  /// 获取tab对应icon
  Image _getTabIcon(int index) {
    return Image.asset(
      _currentIndex == index ? _tabSelectedImages[index] : _tabImages[index],
      width: 24,
      height: 24,
    );
  }

  /// 获取tab对应文字
  Text _getTabText(int index, String title) {
    return Text(title,
        style: TextStyle(
            fontSize: 10,
            color: _currentIndex == index
                ? AppColor.black_66
                : AppColor.black_99));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          bottomNavigationBar: CupertinoTabBar(
            currentIndex: _currentIndex,
            backgroundColor: AppColor.white,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: _getTabIcon(0), title: _getTabText(0, '首页')),
              BottomNavigationBarItem(
                  icon: _getTabIcon(1), title: _getTabText(1, '我的')),
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: <Widget>[HomePage(), MyPage()],
          )),
    );
  }
}
