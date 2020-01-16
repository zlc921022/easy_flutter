import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_repository.dart';
import 'base_view_model.dart';

/// 负责创建viewModel对象和初始化数据加载
class ProviderWidget<T extends BaseViewModel<V>, V extends BaseRepository>
    extends StatefulWidget {
  /// viewModel
  final T model;
  final ValueWidgetBuilder<T> builder;
  final Widget child;

  /// 初始化数据
  final Function(T model) initData;

  @override
  State<StatefulWidget> createState() => _ProviderWidgetState<T, V>();

  ProviderWidget(
      {@required this.model,
      @required this.builder,
      this.child,
      this.initData});
}

class _ProviderWidgetState<T extends BaseViewModel<V>, V extends BaseRepository>
    extends State<ProviderWidget<T, V>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    // 执行initData方法
    widget.initData?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
