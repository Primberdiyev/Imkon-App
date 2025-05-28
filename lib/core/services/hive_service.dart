import 'package:hive/hive.dart';
import 'package:imkon/features/auth/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static late Box<UserModel> userBox;

  static Future<void> initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    Hive.registerAdapter(UserModelAdapter());
    userBox = await Hive.openBox<UserModel>('userBox');
  }

  static Future<void> saveUser(UserModel user) async {
    await userBox.add(user);
  }

  static UserModel getUserModel() {
    return userBox.values.toList().last;
  }

  static Future<void> editUser(int index, UserModel newUser) async {
    await userBox.putAt(index, newUser);
  }
}
