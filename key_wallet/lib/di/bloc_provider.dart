
import 'package:flutter/src/widgets/framework.dart';
import 'package:key_wallet/di/dependecies_provider.dart';
import 'package:key_wallet/login_bloc.dart';
import 'package:provider/src/provider.dart';

class BlocProvider extends DependenciesProvider {
  const BlocProvider(Widget child, {Key? key}) : super(child, key: key, );

  @override
  List<Provider> get providers =>
      [
        Provider<LoginBloc>(create: (context) => LoginBloc())
      ];

}