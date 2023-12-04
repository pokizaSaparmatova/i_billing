import 'package:get_it/get_it.dart';
import 'package:ibilling/features/ibilling/data/datasource/local_datasource/local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc


  // Use cases


  // Repository


  // Data sources



  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<LocalDataSource>(
        () => SharedPreferencesLocalDataSource(sharedPreferences),
  );
  //! Core


  //! External
}
