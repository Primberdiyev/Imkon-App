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

  @HiveField(5)
  DateTime? time;

  @HiveField(6)
  String? imagePath;

  UserModel({
    required this.name,
    required this.surname,
    required this.age,
    required this.region,
    required this.district,
    this.time,
    this.imagePath,
  });

  UserModel copyWith({
    String? name,
    String? surname,
    String? age,
    String? region,
    String? district,
    DateTime? time,
    String? imagePath,
  }) {
    return UserModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      age: age ?? this.age,
      region: region ?? this.region,
      district: district ?? this.district,
      time: time ?? this.time,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
