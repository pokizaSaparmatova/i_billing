import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<String?> getSelectedLanguage();

  Future<void> saveSelectedLanguage(String languageCode);

  String getNumber();

  void saveNumber(String number);
}

class SharedPreferencesLocalDataSource implements LocalDataSource {
  static const String selectedLanguageKey = 'selectedLanguage';
  static const String numbers = 'number';
  final SharedPreferences sharedPreferences;

  SharedPreferencesLocalDataSource(this.sharedPreferences);

  @override
  Future<String> getSelectedLanguage() async {
    print(
        "sharedddddd:${sharedPreferences.getString(selectedLanguageKey) ?? "en"}");
    return sharedPreferences.getString(selectedLanguageKey) ?? "en";
  }

  @override
  Future<void> saveSelectedLanguage(String languageCode) async {
    sharedPreferences.setString(selectedLanguageKey, languageCode);
    print(
        "shareddddddSavedd:${sharedPreferences.getString(selectedLanguageKey) ?? "en"}");
  }

  @override
  String getNumber() {
    print("shareddddddddd:${sharedPreferences.getString(numbers)??""}");
    return sharedPreferences.getString(numbers)??"";
  }

  @override
  void saveNumber(String number) {
  sharedPreferences.setString(numbers, number);
  print("shareddddddddd:${sharedPreferences.getString(numbers)??""}");
  }

}
