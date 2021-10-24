import 'package:flutter/material.dart';
import 'package:key_wallet/password_list/password_list_bloc.dart';
import 'package:key_wallet/shared/repositories/models/password.dart';
import 'package:key_wallet/shared/repositories/models/user.dart';
import 'package:provider/provider.dart';

class PasswordListView extends StatelessWidget {
  PasswordListView(this.login);

  final String login;

  @override
  Widget build(BuildContext context) {
    PasswordListBloc bloc = Provider.of<PasswordListBloc>(context);
    bloc.initalize(login);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            StreamBuilder<Future<User>>(
                                stream: bloc.passwordListStream,
                                builder: (BuildContext context, AsyncSnapshot<Future<User>> future) {
                                  Future<User>? user = future.data;
                                  if (future.hasData && user != null) {
                                    return FutureBuilder<User>(
                                      future: user,
                                      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                                        User? uss = snapshot.data;
                                        if (uss != null && snapshot.hasData) {
                                          return Expanded(
                                            child: ListView.builder(
                                              itemCount: uss.passwords.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () {
                                                    bloc.loadPassword(uss.passwords[index].webAddress);
                                                  },
                                                  title: Text(
                                                    '${uss.passwords[index].webAddress}',
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Text(
                                              'Brak zapisanych haseł',
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    print('DOBRZE');
                                  } else
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          'Brak zapisanych haseł',
                                        ),
                                      ),
                                    );
                                }),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.indigo),
                        child: TextButton(
                          onPressed: bloc.addNewPassword,
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(
                                'Dodaj nowe hasło',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  _showPasswordChangeDialog(context, bloc);
                                },
                                child: Text('Zmień hasło')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Wyloguj'))
                          ],
                        ),
                        StreamBuilder<Future<Password?>>(
                          stream: bloc.passwordShowStream,
                          builder: (BuildContext context, AsyncSnapshot<Future<Password?>> futureSnapshot) {
                            return FutureBuilder<Password?>(
                                future: futureSnapshot.data,
                                builder: (BuildContext context, AsyncSnapshot<Password?> passwordStream) {
                                  Password? data = passwordStream.data;
                                  if (passwordStream.hasData && data != null) {
                                    return passwordData(data);
                                  }
                                  return passwordForm(bloc);
                                });
                          },
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordData(Password data) {
    return Column(
      children: <Widget>[Text(data.webAddress), Text(data.decription), Text(data.login), Text(data.password)],
    );
  }

  Widget passwordForm(PasswordListBloc bloc) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (text) {
            bloc.webAddress = (text);
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'Web adress', hintText: 'Enter Web adress'),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (text) {
            bloc.description = (text);
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'Description', hintText: 'Enter description'),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (text) {
            bloc.login = (text);
          },
          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Login', hintText: 'Enter login'),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (text) {
            bloc.password = (text);
          },
          decoration:
              const InputDecoration(border: OutlineInputBorder(), labelText: 'Password', hintText: 'Enter password'),
        ),
      ),
      TextButton(
          onPressed: () {
            bloc.addNewPasswordObject();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              Text(
                'Dodaj',
              ),
            ],
          )),
    ]);
  }

  void _showPasswordChangeDialog(BuildContext context, PasswordListBloc bloc) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Change password'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  onChanged: bloc.passwordChanged,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password', hintText: 'Enter your secure password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: bloc.sndPasswordChanged,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Powtórz Password', hintText: 'Reenter your secure password'),
                ),
              ),
            Row(children: [
              ElevatedButton(
                  onPressed: () {
                    bool x =bloc.changePassword();
                    if(x){
                      _dismissDialog(context);
                    }
                  },
                  child: Text('Zmień hasło')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Wyloguj'))
            ],)
            ],
          );
        });

  }
  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
