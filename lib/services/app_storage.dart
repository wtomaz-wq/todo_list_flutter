import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

class AppStorage {
 static const String _loggedInKey = 'isLogged';
 static const String _usernameKey = 'username';
 static const String _passwordKey = 'password';
 static const String _darkModeKey = 'darkMode';
 static const String _confirmDeleteKey = 'confirmDelete';

 static const String defaultUSerName = 'aluno';
 static const String defaultPassword = '1234';

 Future<void> ensureDefaultUser() async {
  final prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey(_usernameKey)){
    await prefs.setString(_usernameKey, defaultUSerName);
  }

  if (!prefs.containsKey(_passwordKey)){
    await prefs.setString(_passwordKey, defaultPassword);
  }
 }

 Future<bool> loadIsLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_loggedInKey) ?? false;
 }

 Future<void> setLoggedIn(bool value) async{
 final prefs = await SharedPreferences.getInstance();
 await prefs.setBool(_loggedInKey, value);
 }

 Future<bool> validateLogin(String username, String password) async {
  await ensureDefaultUser();
    final prefs = await SharedPreferences.getInstance();

    final savedUsername = prefs.getString(_usernameKey) ?? defaultUSerName;
    final savedPassword = prefs.getString(_passwordKey) ?? defaultPassword;

    return username == savedUsername && password == savedPassword;
  }

  Future<String> loadPassword()async{
    await ensureDefaultUser();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey) ?? defaultPassword;
  }

  Future<void> savedPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_passwordKey, password);
  }

  Future<AppSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return AppSettings(
      darkMode: prefs.getBool(_darkModeKey) ?? false,
      confirmDelete: prefs.getBool(_confirmDeleteKey) ?? true,
    );
  }

Future<void> saveDarkmode(bool value) async {
 final prefs = await  SharedPreferences.getInstance();
 await prefs.setBool(_darkModeKey, value);
}

Future<void> saveConfirmDelete(bool value) async {
 final prefs = await SharedPreferences.getInstance();
 await prefs.setBool(_confirmDeleteKey, value);
}

}