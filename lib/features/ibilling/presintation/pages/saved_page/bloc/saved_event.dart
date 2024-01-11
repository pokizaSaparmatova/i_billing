part of 'saved_bloc.dart';

@immutable
abstract class SavedEvent {}

class GetSavedListEvent extends SavedEvent {}

class GetSearchSavedListEvent extends SavedEvent {
  final String search;

  GetSearchSavedListEvent(this.search);
}

class GetFilterSavedListEvent extends SavedEvent {
  final DateTime startDate;
  final DateTime endDate;
  final List<String> enumList;

  GetFilterSavedListEvent(
      {required this.startDate, required this.endDate, required this.enumList});
}
