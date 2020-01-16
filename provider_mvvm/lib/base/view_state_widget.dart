import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/app_color.dart';
import 'base_view_model.dart';
import 'view_state.dart';

/// 针对加载中 数据为空 数据加载失败做统一处理
class CommonViewStateHelper<T extends BaseViewModel> extends StatelessWidget {
  final T model;
  final VoidCallback onEmptyPressed;
  final VoidCallback onErrorPressed;

  CommonViewStateHelper({
    @required this.model,
    this.onEmptyPressed,
    this.onErrorPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (model.isLoading()) {
      return new ViewStateLoadingWidget();
    } else if (model.isEmpty()) {
      return new ViewStateEmptyWidget(onPressed: onEmptyPressed);
    } else if (model.isError()) {
      return new ViewStateErrorWidget(
          error: model.viewStateError, onPressed: onErrorPressed);
    } else {
      throw new Exception('状态异常，请核查状态');
    }
  }
}

/// 初始化 加载中
class ViewStateLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColor.white,
      body: new Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  ViewStateEmptyWidget({this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Container(
              width: 88,
              height: 88,
              child: Text(
                message ?? '暂无数据',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColor.black_33),
              ),
            ),
          )),
    );
  }
}

/// 页面数据请求异常
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final VoidCallback onPressed;

  ViewStateErrorWidget({this.error, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Container(
              width: 88,
              height: 88,
              child: Text(
                error?.message ?? '数据请求异常',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColor.black_33),
              ),
            ),
          )),
    );
  }
}
