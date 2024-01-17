import 'package:get_it/get_it.dart';
import 'package:ibilling/features/ibilling/data/datasource/local_datasource/local_datasource.dart';
import 'package:ibilling/features/ibilling/data/repository/i_billing_repositoryImpl.dart';
import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';
import 'package:ibilling/features/ibilling/domain/usecases/add_contract.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_all_contracts.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_contact.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_next_contract.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_saved_list.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_search_list.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_single_list_contract.dart';
import 'package:ibilling/features/ibilling/domain/usecases/remove_contract.dart';
import 'package:ibilling/features/ibilling/domain/usecases/saved_contract.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/bloc/contact_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_page/bloc/saved_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(() => ContactBloc(
      getContactUsecase: sl(),
      getNextContract: sl(),
      getAllContract: sl(),
      getSearchList: sl(),
    removeContract: sl(),
    getSingleListContract: sl(),
    localDataSource: sl(),
    savedContract: sl(),

  ));


  // Use cases
  sl.registerLazySingleton(() => CrudContact(sl()));
  sl.registerLazySingleton(() => GetContact(sl()));
  sl.registerLazySingleton(() => GetNextContract(sl()));
  sl.registerLazySingleton(() => GetAllContract(sl()));
  sl.registerLazySingleton(() => GetSearchList(sl()));
  sl.registerLazySingleton(() => RemoveContract(sl()));
  sl.registerLazySingleton(() => GetSingleListContract(sl()));
  sl.registerLazySingleton(() => SavedContract(sl()));
  sl.registerLazySingleton(() => GetSavedList(sl()));

  // Repository
  sl.registerLazySingleton<IBillingRepository>(
    () => IBillingRepositoryImpl(),
  );

  // Data sources

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<LocalDataSource>(
    () => SharedPreferencesLocalDataSource(sharedPreferences),
  );
  //! Core

  //! External
}
