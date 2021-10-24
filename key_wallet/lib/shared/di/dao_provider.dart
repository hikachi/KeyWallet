import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:key_wallet/shared/repositories/user_dao.dart';
import 'package:provider/src/provider.dart';

import 'dependecies_provider.dart';

class DaoProvider extends DependenciesProvider {
  DaoProvider(Widget child, this.box) : super(child);
  Box box;

  @override
  List<Provider> get providers => [Provider<UserDao>(create: (context) => UserDao(box))];
}
