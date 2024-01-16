import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<VM extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, VM model, Widget? child) builder;
  final VM viewModel;
  final Widget? child;
  final Function(VM) onModelReady;

  const BaseWidget({
    super.key,
    required this.builder,
    required this.viewModel,
    this.child,
    required this.onModelReady,
  });

  @override
  State<BaseWidget<VM>> createState() => _BaseWidgetState<VM>();
}

class _BaseWidgetState<VM extends ChangeNotifier> extends State<BaseWidget<VM>> {
  late VM viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    widget.onModelReady(viewModel);
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VM>(
      create: (context) => viewModel,
      child: Consumer<VM>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}