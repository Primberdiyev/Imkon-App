import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String surname;

  @HiveField(2)
  String age;

  @HiveField(3)
  String region;

  @HiveField(4)
  String district;

  UserModel({
    required this.name,
    required this.surname,
    required this.age,
    required this.region,
    required this.district,
  });
}
