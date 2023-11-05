import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  String passwordHash;

  User(this.username, this.passwordHash);
}
