import 'package:hive/hive.dart';
import 'package:key_wallet/shared/repositories/models/password.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User{
  User(this.login, this.passwordHash, this.salt, this.isPasswordKeptAsHash, this.passwords);

  @HiveField(1)
  final String login;
  @HiveField(3)
  String passwordHash;
  @HiveField(4)
  String salt;
  @HiveField(5)
  final bool isPasswordKeptAsHash;
  @HiveField(6)
  List<Password> passwords;
}