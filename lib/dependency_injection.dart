import 'package:get_it/get_it.dart';
import 'package:ibilling/features/ibilling/data/datasource/local_datasource/local_datasource.dart';
import 'package:ibilling/features/ibilling/data/repository/i_billing_repositoryImpl.dart';
import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';
import 'package:ibilling/features/ibilling/domain/usecases/crud_contact.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_contact.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/bloc/contact_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
          () => ContactBloc(getContactUsecase: sl()));

  // Use cases
  sl.registerLazySingleton(() => CrudContact(sl()));
  sl.registerLazySingleton(() => GetContact(sl()));

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
