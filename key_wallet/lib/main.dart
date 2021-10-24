import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:key_wallet/login/login_view.dart';
import 'package:key_wallet/shared/di/bloc_provider.dart';
import 'package:key_wallet/shared/di/dao_provider.dart';
import 'package:key_wallet/shared/repositories/const.dart';
import 'package:key_wallet/shared/repositories/models/password.dart';

import 'package:key_wallet/shared/repositories/models/user.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

// main() async{
//   Directory directory = await pathProvider.getApplicationDocumentsDirectory();
//   Hive.init(directory.path);
//   Hive.registerAdapter(UserAdapter());
//   Hive.registerAdapter(PasswordAdapter());
//   var box = await Hive.openBox(Const.hiveUserBox);
//   box.clear();
//   box.deleteFromDisk();
// }
Future<void> main() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PasswordAdapter());
  var box = await Hive.openBox(Const.hiveUserBox);
  runApp(
    DaoProvider(
      const BlocProvider(
        MyApp(),
      ),
      box,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
