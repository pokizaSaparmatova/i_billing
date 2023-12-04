
import 'package:shared_preferences/shared_preferences.dart';
abstract class LocalDataSource {
  Future<String?> getSelectedLanguage();
  Future<void> saveSelectedLanguage(String languageCode);
}


class SharedPreferencesLocalDataSource implements LocalDataSource {
  static const String selectedLanguageKey = 'selectedLanguage';
  final SharedPreferences sharedPreferences;

  SharedPreferencesLocalDataSource(this.sharedPreferences);

  @override
  Future<String> getSelectedLanguage() async {

print("sharedddddd:${sharedPreferences.getString(selectedLanguageKey)?? "en"}");
    return sharedPreferences.getString(selectedLanguageKey)?? "en";
  }

  @override
  Future<void> saveSelectedLanguage(String languageCode) async {
    sharedPreferences.setString(selectedLanguageKey, languageCode);
    print("shareddddddSavedd:${sharedPreferences.getString(selectedLanguageKey)?? "en"}");
  }
}
