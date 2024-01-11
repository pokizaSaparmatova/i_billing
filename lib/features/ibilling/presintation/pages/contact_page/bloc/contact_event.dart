part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class ChangeChipChoiceEvent extends ContactEvent {
  final bool chipChoiceEnum;

  ChangeChipChoiceEvent(this.chipChoiceEnum);
}

class GetAllContractsEvent extends ContactEvent {
  final DateTime dateTime;

  GetAllContractsEvent({required this.dateTime});
}

class LoadMoreDataEvent extends ContactEvent {
  final DateTime dateTime;

  LoadMoreDataEvent({required this.dateTime});
}

class UpdateIndicatorEvent extends ContactEvent {
  final bool value;

  UpdateIndicatorEvent(this.value);
}

class GetSearchListEvent extends ContactEvent {
  final String search;

  GetSearchListEvent(this.search);
}

class GetFilterListEvent extends ContactEvent {
  final DateTime startDate;
  final DateTime endDate;
  final List<String> enumList;

  GetFilterListEvent(
      {required this.startDate, required this.endDate, required this.enumList});
}

class DeleteContractEvent extends ContactEvent {
  final String id;

  DeleteContractEvent({required this.id});
}

class GetSingleListContractEvent extends ContactEvent {
  final String name;

  GetSingleListContractEvent(this.name);
}

class SavedContractEvent extends ContactEvent {
  final String id;
  final bool isSaved;
  final ContactModel contactModel;

  SavedContractEvent(
      {required this.id, required this.isSaved, required this.contactModel});
}
class AddDaysToListEvent extends ContactEvent{

}
class AddWeekListEvent extends ContactEvent{
  final DateTime currentDate;

  AddWeekListEvent(this.currentDate);
}
// class GetSelectedDateListEvent extends ContactEvent{
//   final DateTime dateTime;
//
//   GetSelectedDateListEvent({required this.dateTime});
// }
