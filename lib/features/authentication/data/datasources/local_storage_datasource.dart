import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageDatasource {
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> clearAuthToken();
}

class SharedPreferencesDataSource implements LocalStorageDatasource {
  final SharedPreferences preferences;

  SharedPreferencesDataSource(this.preferences);

  @override
  Future<void> saveAuthToken(String token) async {
    await preferences.setString('auth_token', token);
  }

  @override
  Future<void> clearAuthToken() async {
    await preferences.remove('auth_token');
  }

  @override
  Future<String?> getAuthToken() async {
    return preferences.getString('auth_token');
  }
}
