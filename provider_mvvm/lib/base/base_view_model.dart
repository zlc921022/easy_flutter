import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'base_repository.dart';
import 'view_state.dart';

/// 父类ViewModel
abstract class BaseViewModel<T extends BaseRepository> with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool disposed = false;

  /// 初始化状态为加载中
  ViewState _state = ViewState.loading;

  ViewState get state => _state;

  /// 错误状态类
  ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  /// 是否是刷新状态
  bool isRefresh = false;

  /// 是否是加载更多
  bool isLoadMore = false;

  T mRepository;

  BaseViewModel({ViewState state}) {
    this._state = state;
    mRepository = createRepository();
  }

  /// 通用请求数据方法 子类可以复写
  Future<dynamic> requestData(Future<dynamic> f) async {
    if (!isLoadMore && !isRefresh) {
      setLoading();
    }
    try {
      var result = await f;
      if (result.code != 200) {
        setError(new Exception(), message: result.message);
      }
      return result;
    } catch (e) {
      print(e.toString());
      setError(e);
    }
  }

  /// 提供一个创建Repository对象的抽象方法
  T createRepository();

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  /// 初始化状态
  void setLoading() {
    setState(ViewState.loading);
  }

  /// 数据成功不为空
  void setSuccess() {
    setState(ViewState.success);
  }

  /// 数据成功且为空
  void setEmpty() {
    setState(ViewState.empty);
  }

  /// 数据异常
  void setError(e, {String message}) {
    if (e is DioError) {
      e = e.error;
      message = e.message;
    }
    _viewStateError = new ViewStateError(error: e, message: message);
    setState(ViewState.error);
  }

  /// 设置状态改变
  void setState(ViewState state) {
    this._state = state;
    notifyListeners();
  }

  /// 加载中状态
  bool isLoading() {
    return this._state == ViewState.loading;
  }

  /// 数据为空状态
  bool isEmpty() {
    return this._state == ViewState.empty;
  }

  /// 数据异常状态
  bool isError() {
    return this._state == ViewState.error;
  }

  /// 数据加载成功状态 不为空
  bool isSuccess() {
    return this._state == ViewState.success;
  }

  /// 是否是成功显示数据状态
  /// false 表示数据状态为加载中 数据为空 或者数据加载失败
  /// true 数据成功 or 刷新状态 or 加载更多状态
  bool isSuccessShowDataState() {
    return isSuccess() || isRefresh || isLoadMore;
  }
}
