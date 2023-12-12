import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:ibilling/features/ibilling/data/datasource/local_datasource/local_datasource.dart';
import 'package:ibilling/features/ibilling/domain/usecases/crud_contact.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_contact.dart';
import 'package:ibilling/features/ibilling/presintation/pages/home_page.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'features/ibilling/presintation/pages/contact_page/bloc/contact_bloc.dart';
import 'features/ibilling/presintation/pages/profile_page/bloc/profile_bloc.dart';
import 'firebase_options.dart';

import 'dependency_injection.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await init();
  final localDatasource = sl<LocalDataSource>();
  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('uz')],
    path: 'assets/translations',
    fallbackLocale:
        Locale(await localDatasource.getSelectedLanguage().toString()),
    assetLoader: CodegenLoader(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
            create: (BuildContext context) =>
                ProfileBloc(localDataSource: sl())),
        BlocProvider<AddPageBloc>(
            create: (BuildContext context) => AddPageBloc(usecase: sl(),)),
      ],
      child: Portal(
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
