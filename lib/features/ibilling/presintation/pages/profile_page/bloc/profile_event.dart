part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ChangeOptions extends ProfileEvent {
  final BuildContext context;
  final String applyLanguage;

  ChangeOptions(this.context,this.applyLanguage);
}

class SelectedLanguage extends ProfileEvent {
  final String selectedLanguage;

  SelectedLanguage(this.selectedLanguage);
}

class LoadLanguage extends ProfileEvent {}
