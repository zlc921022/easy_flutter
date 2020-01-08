import 'package:flutter/material.dart';
import 'package:flutter_movie/base/base_repository.dart';
import 'package:flutter_movie/base/view_state.dart';

/// 父类ViewModel
abstract class BaseViewModel<T extends BaseRepository> with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;
  T mRepository;

  /// 初始化状态为加载中
  ViewState state = ViewState.loading;

  BaseViewModel() {
    mRepository = createRepository();
  }

  /// 通用请求数据方法
  Future<dynamic> requestData(Future<dynamic> f) async {
    if (_disposed) {
      return null;
    }
    try {
      setState(ViewState.loading);
      var result = await f;
      if (result.code == 200) {
        setState(ViewState.success);
      } else {
        setState(ViewState.error);
      }
      setState(ViewState.loaded);
      return result;
    } catch (e) {
      print(e.toString());
      setState(ViewState.error);
      setState(ViewState.loaded);
      return null;
    }
  }

  /// 提供一个创建Repository对象的抽象方法
  T createRepository();

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// 设置状态改变
  void setState(ViewState state) {
    this.state = state;
    if (state == ViewState.loaded) {
      notifyListeners();
    }
  }
}
