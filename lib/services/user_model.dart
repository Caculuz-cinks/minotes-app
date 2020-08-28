import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  String token;
  @HiveField(4)
  String user_ref_id;

  UserModel({ this.name, this.email, this.password, this.token, this.user_ref_id });
}
