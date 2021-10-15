import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider(this.child, {Key? key}) : super(key: key);

  final Widget child;

  List<Provider<dynamic>> get providers;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providers, child: child);
  }
}
