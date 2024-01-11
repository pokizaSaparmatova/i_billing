import 'package:shared_preferences/shared_preferences.dart';

import '../../models/contact_model.dart';

abstract class LocalDataSource {
  Future<String?> getSelectedLanguage();

  Future<void> saveSelectedLanguage(String languageCode);

  bool getBool(ContactModel contactModel);
  void setBool(ContactModel contactModel);
}

class SharedPreferencesLocalDataSource implements LocalDataSource {
  static const String selectedLanguageKey = 'selectedLanguage';
  static const String numbersKey = 'number';

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
  void setBool(ContactModel contactModel) {
   sharedPreferences.setBool("${contactModel.name}", contactModel.isSaved);
   print("pressLocal:${contactModel.isSaved}");
  }

  @override
  bool getBool(ContactModel contactModel) {
    return sharedPreferences.getBool(contactModel.name)??false;
  }






}
