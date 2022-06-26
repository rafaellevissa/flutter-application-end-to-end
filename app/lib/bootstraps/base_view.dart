import 'package:dqrtech/bootstraps/base_model.dart';
import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Function(BuildContext, T)? builder;
  final Function(T)? onModelReady;
  final Function(T)? onDispose;
  late final T? viewModel;

  BaseView({
    required this.builder,
    this.onModelReady,
    this.onDispose,
    this.viewModel,
    Key? key,
  }) : super(key: key) {
    viewModel ??= DependencyBase.resolverInstance.resolve(T);

    if (viewModel != null) {
      onModelReady?.call(viewModel!);
    }
  }

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      builder: (context, _) => widget.builder?.call(context, widget.viewModel!),
    );
  }

  @override
  void dispose() {
    widget.onDispose?.call(widget.viewModel!);
    super.dispose();
  }
}
