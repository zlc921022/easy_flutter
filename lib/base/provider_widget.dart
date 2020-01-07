import 'package:flutter/material.dart';
import 'package:flutter_movie/base/base_repository.dart';
import 'package:flutter_movie/base/base_view_model.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends BaseViewModel<V>,V extends BaseRepository> extends StatefulWidget {
  final T model;
  final ValueWidgetBuilder<T> builder;
  final Widget child;
  final Function(T model) initData;

  @override
  State<StatefulWidget> createState() => _ProviderWidgetState<T,V>();

  ProviderWidget(
      {@required this.model,
      @required this.builder,
      this.child,
      this.initData});
}

class _ProviderWidgetState<T extends BaseViewModel<V>,V extends BaseRepository>
    extends State<ProviderWidget<T,V>> {
  T model;

  @override
  void initState() {
    model = widget.model;
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
