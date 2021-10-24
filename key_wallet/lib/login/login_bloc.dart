import 'package:flutter/material.dart';
import 'package:key_wallet/password_list/password_list.dart';
import 'package:key_wallet/shared/repositories/user_dao.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  LoginBloc(this._user, this.context);

  final BuildContext context;

  final UserDao _user;
  final BehaviorSubject _loginSink = BehaviorSubject<String>();
  final BehaviorSubject _passwordSink = BehaviorSubject<String>();

  Stream<String> get _loginStream => _loginSink.map((event) => event);

  Stream<String> get _passwordStream => _passwordSink.map((event) => event);

  void loginChanged(String login) {
    _loginSink.sink.add(login);
  }

  void passwordChanged(String password) {
    _passwordSink.sink.add(password);
  }

  void checkLogin(BuildContext context) async {
    String login = _loginSink.value;
    String password = _passwordSink.value;
    print(login+" "+password);

    if (_user.authorization(login, password)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordListView(login),
        ),
      );
    }
  }
}
