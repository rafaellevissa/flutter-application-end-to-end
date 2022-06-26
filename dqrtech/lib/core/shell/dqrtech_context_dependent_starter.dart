import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:dqrtech/services/media_query_service.dart';
import 'package:flutter/material.dart';

class DqrtechContextDependentStarter extends StatefulWidget {
  final Widget child;

  const DqrtechContextDependentStarter({Key? key, required this.child}) : super(key: key);

  @override
  _DqrtechContextDependentStarterState createState() => _DqrtechContextDependentStarterState();
}

class _DqrtechContextDependentStarterState extends State<DqrtechContextDependentStarter> {
  @override
  void didChangeDependencies() {
    var mediaQueryService = DependencyBase.resolve<MediaQueryService>(MediaQueryService);
    mediaQueryService.init(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
