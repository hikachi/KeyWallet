import 'package:flutter/material.dart';
import 'package:key_wallet/login_bloc.dart';
import 'package:key_wallet/login_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc())
      ],
        child: MyApp(),
      ));
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
