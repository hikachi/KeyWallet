import 'package:flutter/material.dart';
import 'package:key_wallet/register/register_bloc.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterBloc bloc = Provider.of<RegisterBloc>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: const Text('Zarejestruj konto')),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: bloc.loginChanged,
                decoration:
                    InputDecoration(border: OutlineInputBorder(), labelText: 'User Name', hintText: 'Enter login'),
              ),
            ),
            Container(
              height: 30,
              child: StreamBuilder<bool>(
                stream: bloc.validate,
                builder: (BuildContext context, AsyncSnapshot<bool> data) {
                  var dat = data.data;
                  if (data.hasData && dat != null && dat == true) {
                    return Container();
                  }
                  return Padding(
                      padding: EdgeInsets.all(3),
                      child: const Text(
                        'Hasła nie pasują',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                onChanged: bloc.passwordChanged,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password', hintText: 'Enter your secure password'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: bloc.sndPasswordChanged,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password', hintText: 'Reenter your secure password'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  StreamBuilder<bool>(
                      stream: bloc.validate,
                      builder: (BuildContext context, AsyncSnapshot<bool> data) {
                        var dat = data.data;
                        if (data.hasData && dat != null && dat == true) {
                          return ElevatedButton(
                              onPressed: () {
                                bloc.register();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Zarejestruj'));
                        }
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey),
                          ),
                          onPressed: () {},
                          child: const Text('Zarejestruj'),
                        );
                      }),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    StreamBuilder<bool>(
                      stream: bloc.isHashStream,
                      builder: (BuildContext context, AsyncSnapshot<bool> data) {
                        var dat = data.data;
                        if (data.hasData && dat != null) {
                          return Switch(
                              value: dat,
                              onChanged: (isHash) {
                                bloc.isHashSChanged(isHash);
                              });
                        }
                        return Switch(
                            value: false,
                            onChanged: (isHash) {
                              bloc.isHashSChanged(isHash);
                            });
                      },
                    ),
                    Text('Hasło jako hash'),
                  ],
                ))
          ],
        ));
  }
}
