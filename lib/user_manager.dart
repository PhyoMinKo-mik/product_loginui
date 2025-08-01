import 'package:hive/hive.dart';
import 'package:product_loginui/user_data_model/personal_data.dart';
import 'package:product_loginui/user_model.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  static UserManager get instance => _instance;

  late UserModel _user;
  PersonalData? _personalData;

  UserModel get currentUser => _user;
  PersonalData? get personalData => _personalData;

  UserManager._internal();

  void loadFromHive(UserModel user) => _user = user;

  void updateUser(UserModel newUser) {
    _user = newUser;
    Hive.box<UserModel>('userBox').put('currentUser', newUser);
  }

  void setPersonalData(PersonalData data) => _personalData = data;

  void logout() {
    Hive.box<UserModel>('userBox').delete('currentUser');
    _personalData = null;
  }
}
