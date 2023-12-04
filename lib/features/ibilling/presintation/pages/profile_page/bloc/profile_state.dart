part of 'profile_bloc.dart';

class ProfileState extends Equatable{
  final String selectedlanguge;
  final String currentLang;

  const ProfileState({this.selectedlanguge = "en", this.currentLang = ''});

  ProfileState copyWith({String? selectedlanguge, String? currentLang}) {
    return ProfileState(
        selectedlanguge: selectedlanguge ?? this.selectedlanguge,
        currentLang: currentLang ?? this.currentLang);
  }

  @override
  List<Object?> get props => [selectedlanguge,currentLang];

//   final List<LanguageParam> languages;
//   final LanguageParam selectedLanguage;
//
//   ProfileState( {this.languages=const [
//     LanguageParam(index:0,  name:'english',),
//     LanguageParam( index:1,name: 'uzbek',),
//   ],
//     this.selectedLanguage= const LanguageParam(),});
//
//   ProfileState copyWith({  final List<LanguageParam>? languages,
//   final LanguageParam? selectedLanguage,}) {
//     return ProfileState(
//       languages: languages ?? this.languages,
//       selectedLanguage: selectedLanguage ?? this.selectedLanguage,
//     );
//   }
// }
//
// class LanguageParam{
//   final int index;
//   final String name;
//   const LanguageParam({this.index = -1, this.name=''});
}
