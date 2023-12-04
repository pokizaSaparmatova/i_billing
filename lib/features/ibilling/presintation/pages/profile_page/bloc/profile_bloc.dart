import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../../dependency_injection.dart';
import '../../../../data/datasource/local_datasource/local_datasource.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  var localDataSource=sl<LocalDataSource>();
  ProfileBloc({required this.localDataSource}) : super(ProfileState()) {
    on<SelectedLanguage>((event,emit){
      emit(state.copyWith(selectedlanguge: event.selectedLanguage));
    });
    on<LoadLanguage>((event,emit)async{
      emit(state.copyWith(currentLang: await localDataSource.getSelectedLanguage()));
      print("getlan:${state.currentLang}");
    });
    on<ChangeOptions>((event, emit) {
            event.context.setLocale(Locale(event.applyLanguage));
     print("applyLan:${event.applyLanguage}");
      localDataSource.saveSelectedLanguage(event.applyLanguage);
      print("save:${event.applyLanguage}");
      emit(state.copyWith(currentLang: event.applyLanguage));
    });
  }
}
