import 'package:key_wallet/shared/hash_functions.dart';
import 'package:key_wallet/shared/repositories/models/password.dart';
import 'package:key_wallet/shared/repositories/models/user.dart';
import 'package:key_wallet/shared/repositories/user_dao.dart';
import 'package:rxdart/rxdart.dart';

class PasswordListBloc {
  final UserDao userDao;

  PasswordListBloc(this.userDao);

  String mainLogin = '';
  String _webAddress = '';
  String _description = '';
  String _login = '';
  String _password = '';
  final BehaviorSubject<String> _userSink = BehaviorSubject<String>();
  final BehaviorSubject<String?> _passwordSink = BehaviorSubject<String?>();

  final BehaviorSubject _passwordSinkch = BehaviorSubject<String>();
  final BehaviorSubject _secondPasswordSinkch = BehaviorSubject<String>();
  Stream<String> get _passwordStreamch => _passwordSinkch.map((event) => event);
  Stream<String> get _secondPasswordStreamch => _secondPasswordSinkch.map((event) => event);



  void passwordChanged(String password){
    _passwordSinkch.sink.add(password);
  }
  void sndPasswordChanged(String sndPassword){
    _secondPasswordSinkch.sink.add(sndPassword);
  }
  List<Password> _passwordsList = [];
  late final User user;

  Stream<Future<User>> get passwordListStream => _userSink.map((login) async {
        return await userDao.getUserFuture(login);
      });

   Stream<Future<Password?>> get passwordShowStream => _passwordSink.map((webAdr) async {
        return await userDao.getUserPassword(mainLogin, webAdr??'');
      });

  set webAddress(String value) {
    _webAddress = value;
  }

  void initalize(String login) {
    mainLogin = login;
    _userSink.add(mainLogin);
  }

  void loadPassword(String webAddress) {
    _passwordSink.add(webAddress);
  }

  void addNewPassword() {
    _passwordSink.add(null);
  }

  void addNewPasswordObject() {
    Password pass = userDao.createPassword(_webAddress, _description, _login, _password, mainLogin);
    userDao.addPasswordToLogin(mainLogin, pass);
    print(_webAddress + " " + _description + " " + _login + " " + _password);
    _webAddress = '';
    _description = '';
    _login = '';
    _password = '';
    _passwordSink.add(null);
    _userSink.add(mainLogin);
  }

  set description(String value) {
    _description = value;
  }

  set login(String value) {
    _login = value;
  }

  set password(String value) {
    _password = value;
  }
  bool changePassword(){
    if(_passwordSinkch.value == _secondPasswordSinkch.value && _passwordSinkch.value !=''){
      userDao.changePassword(mainLogin, _passwordSinkch.value);
      return true;
    }
    return false;
  }
}
