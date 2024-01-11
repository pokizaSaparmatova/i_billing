part of 'saved_bloc.dart';

@immutable
class SavedState {
  final String errorMessage;
  final PageStatuses pageStatuses;
  final List<ContactModel> savedList;
  final String search;

  SavedState({this.errorMessage = "",
    this.pageStatuses = PageStatuses.initial,
    this.savedList = const [],
    this.search="",

  });

  SavedState copyWith({
    String? errorMessage,
    PageStatuses? pageStatuses,
    List<ContactModel>? savedList,
    String? search,


  }) {
    return SavedState(
      errorMessage: errorMessage ?? this.errorMessage,
      pageStatuses: pageStatuses ?? this.pageStatuses,
      savedList: savedList ?? this.savedList,
      search: search?? this.search

    );
  }
}
