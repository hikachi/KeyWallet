import 'package:flutter/material.dart';
import 'package:key_wallet/login_view.dart';

void main() {
  runApp(MyApp());
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
