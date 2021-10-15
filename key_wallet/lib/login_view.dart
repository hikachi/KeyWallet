import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:key_wallet/register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Key wallet")),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor])),
        child: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Center(
            child: SizedBox(
              width: 500,
              child: Column(
                children: <Widget>[
                  Image(image: const AssetImage('assets/images/logo.png')),
                  const SizedBox(
                    height: 100,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                          hintText: 'Enter login'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password', hintText: 'Enter your secure password'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[ElevatedButton(onPressed: () {}, child: Text('Zaloguj'))],
                    ),
                  ),
                  const Divider(),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(text: "Nie masz konta ? "),
                    TextSpan(
                        text: 'Zarejestruj się.',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView())))
                  ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
