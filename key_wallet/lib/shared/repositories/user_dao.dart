import 'package:hive/hive.dart';
import 'package:key_wallet/shared/hash_functions.dart';
import 'package:key_wallet/shared/repositories/models/password.dart';

import 'const.dart';
import 'models/user.dart';

class UserDao {
  UserDao(this.userBox);

  final Box userBox;

  User? getUser(String login) {
    return userBox.get(login);
  }

  Future<User> getUserFuture(String login) async {
    return await userBox.get(login);
  }

  Future<Password?> getUserPassword(String login, String webAdr) async {
    User x = await userBox.get(login);
    try {
      Password pass = x.passwords.firstWhere((element) => element.webAddress == webAdr);
      Password newPassObject = Password(HashFunctions().calcDecryAes(pass.password, x.salt), pass.webAddress, pass.decription, pass.login);
      return newPassObject;
    } catch (e) {
      return null;
    }
  }

  bool createUser(String login, String password, bool isHash) {
    if (!userBox.containsKey(login)) {
      String salt = HashFunctions().getRandomPepper();
      String passwordHash =
          isHash ? HashFunctions().calcHmac(password) : HashFunctions().calcSHA512(password, Const.pepper, salt);
      User user = User(login, passwordHash, salt, false, []);
      print('Add to db: $user');
      userBox.put(login, user);
      return true;
    }
    return false;
  }

  bool authorization(String login, String password) {
    if (userBox.containsKey(login)) {
      User user = userBox.get(login);
      String pass = user.isPasswordKeptAsHash
          ? HashFunctions().calcHmac(password)
          : HashFunctions().calcSHA512(password, Const.pepper, user.salt);

      if (user.passwordHash == pass) {
        return true;
      }
      return false;
    }
    return false;
  }

  bool addPasswordToLogin(String login, Password password) {
    if (userBox.containsKey(login)) {
      User user = userBox.get(login);
      var passwordList = user.passwords;
      passwordList.add(password);
      user.passwords = passwordList;
      userBox.put(login, user);
      return true;
    }
    return false;
  }

  Password createPassword(String webAdress, String decription, String login, String password, String userLogin) {
    User user = userBox.get(userLogin);
    String pass = HashFunctions().calcEnryptAes(password, user.salt);
    return Password(pass, webAdress, decription, login);
  }

  void changePassword(String login, String newPassword) {
    if (userBox.containsKey(login)) {
      User user = userBox.get(login);
      String salt = HashFunctions().getRandomPepper();

      String passwordHash = user.isPasswordKeptAsHash
          ? HashFunctions().calcHmac(newPassword)
          : HashFunctions().calcSHA512(newPassword, Const.pepper, salt);

      List<Password> newPasswords =[];
      for(Password pass in user.passwords){
        String x = HashFunctions().calcDecryAes(pass.password, user.salt);
        String newPass = HashFunctions().calcEnryptAes(x, salt);
        newPasswords.add(Password(newPass,pass.webAddress, pass.decription, pass.login ));
      }
      user.salt = salt;
      user.passwordHash = passwordHash;
      user.passwords = newPasswords;
    }
  }
}
