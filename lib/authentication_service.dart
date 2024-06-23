import 'package:hive/hive.dart';

class AuthenticationService {
  static final _authBox = Hive.box('authBox');
  static const _predefinedUsername = 'user';
  static const _predefinedPassword = 'password';

  static bool login(String username, String password) {
    if (username == _predefinedUsername && password == _predefinedPassword) {
      _authBox.put('isAuthenticated', true);
      return true;
    }
    return false;
  }

  static void logout() {
    _authBox.put('isAuthenticated', false);
  }

  static bool isAuthenticated() {
    return _authBox.get('isAuthenticated', defaultValue: false);
  }
}
