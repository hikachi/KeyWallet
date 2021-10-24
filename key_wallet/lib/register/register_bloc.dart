import 'package:flutter/material.dart';
import 'package:key_wallet/shared/repositories/user_dao.dart';
import 'package:rxdart/rxdart.dart';
class RegisterBloc{
  RegisterBloc(this.userDao, this.context);
  final UserDao userDao;
  final BuildContext context;

  final BehaviorSubject _loginSink = BehaviorSubject<String>();
  final BehaviorSubject _passwordSink = BehaviorSubject<String>();
  final BehaviorSubject _secondPasswordSink = BehaviorSubject<String>();
  final BehaviorSubject _isHashSink = BehaviorSubject<bool>();

  Stream<String> get _loginStream => _loginSink.map((event) => event);
  Stream<String> get _passwordStream => _passwordSink.map((event) => event);
  Stream<String> get _secondPasswordStream => _secondPasswordSink.map((event) => event);
  Stream<bool> get isHashStream => _isHashSink.map((event) => event);
  Stream<bool> get validate => Rx.combineLatest2(_passwordStream, _secondPasswordStream, (a, b,) => b==a);
  void loginChanged(String login){
    _loginSink.sink.add(login);
  }
  void passwordChanged(String password){
    _passwordSink.sink.add(password);
  }
  void sndPasswordChanged(String sndPassword){
    _secondPasswordSink.sink.add(sndPassword);
  }
  void isHashSChanged(bool isHash){
    _isHashSink.add(isHash);
  }
  void register()async {
    String login = _loginSink.value;
    String password = _passwordSink.value;
    bool? isHash = _isHashSink.value;

    userDao.createUser(login, password, isHash??false);
  }

}