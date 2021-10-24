import 'package:hive/hive.dart';

part'password.g.dart';
@HiveType(typeId: 1)
class Password{
  Password(this.password, this.webAddress, this.decription, this.login);
  @HiveField(1)
  String password;
  @HiveField(2)
  final String webAddress;
  @HiveField(3)
  final String decription;
  @HiveField(4)
  final String login;


}