import 'package:flutter/material.dart';
import 'package:flutter_movie/base/base_view_model.dart';

class ViewModelProvider<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  final Widget child;

  ViewModelProvider({@required this.viewModel, @required this.child});

  static V of<V extends BaseViewModel>(BuildContext context) {
    final type = _typeOf<ViewModelProvider<V>>();
    ViewModelProvider<V> provider = context.ancestorWidgetOfExactType(type);
    return provider.viewModel;
  }

  static Type _typeOf<V>() => V;

  @override
  State<StatefulWidget> createState() {
    return _ViewModelProviderState();
  }
}

class _ViewModelProviderState extends State<ViewModelProvider> {
  @override
  Widget build(BuildContext context) {
    return this.widget.child;
  }

  @override
  void dispose() {
    this.widget.viewModel.dispose();
    super.dispose();
  }
}
