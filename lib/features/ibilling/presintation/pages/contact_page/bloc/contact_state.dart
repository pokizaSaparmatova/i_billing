part of 'contact_bloc.dart';

@immutable
class ContactState {
  final String errorMessage;
  final PageStatuses pageStatuses;
  final List<ContactModel> list;
  final List<ContactModel> allContractList;
  final bool chipChoiceEnum;
  final bool isLoading;
  final int perPage;
  final int present;
  final int total;
  final String search;
  final bool isFiltered;
  final bool isSaved;
  final DateTime selectedDates;
  final List<DateTime> dateList;

  ContactState(
      {this.errorMessage = "",
      this.pageStatuses = PageStatuses.initial,
      this.list = const [],
      this.allContractList = const [],
      this.chipChoiceEnum = true,
      this.isLoading = false,
      this.perPage = 10,
      this.present = 0,
      this.total = 100,
      this.search = "",
      this.isFiltered = false,
      this.isSaved = false,
      this.dateList = const [],
      DateTime? selectedDates})
      : selectedDates = selectedDates ?? DateTime.now();

  ContactState copyWith(
      {String? errorMessage,
      PageStatuses? pageStatuses,
      List<ContactModel>? list,
      List<ContactModel>? allContractList,
      bool? chipChoiceEnum,
      bool? isLoading,
      int? perPage,
      int? present,
      int? total,
      String? search,
      bool? isFiltered,
      bool? isSaved,
      List<DateTime>? dateList,
      DateTime? selectedDates}) {
    return ContactState(
        errorMessage: errorMessage ?? this.errorMessage,
        pageStatuses: pageStatuses ?? this.pageStatuses,
        list: list ?? this.list,
        allContractList: allContractList ?? this.allContractList,
        chipChoiceEnum: chipChoiceEnum ?? this.chipChoiceEnum,
        isLoading: isLoading ?? this.isLoading,
        perPage: perPage ?? this.perPage,
        present: present ?? this.present,
        total: total ?? this.total,
        search: search ?? this.search,
        isFiltered: isFiltered ?? this.isFiltered,
        isSaved: isSaved ?? this.isSaved,
        dateList: dateList ?? this.dateList,
        selectedDates: selectedDates ?? this.selectedDates);
  }
}
