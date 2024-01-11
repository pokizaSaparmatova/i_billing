part of 'add_page_bloc.dart';

@immutable
class AddPageState extends Equatable {
  final String title;
  final String entities;
  final String name;
  final String organization;
  final String inn;
  final String status;
  final PageStatuses pageStatuses;
  final String errorMessage;
  final DateTime? date;
  final String selectedText;
  final String currentText;

  const AddPageState(
      {this.title = "",
      this.entities = "",
      this.name = "",
      this.inn = "",
      this.status = "",
      this.organization = "",
      this.pageStatuses = PageStatuses.initial,
      this.errorMessage = "",
      this.date ,
      this.selectedText = "",
      this.currentText = ""});

  AddPageState copyWith(
      {String? title,
      String? entities,
      String? name,
      String? organization,
      String? inn,
      String? status,
      PageStatuses? pageStatuses,
      String? errorMessage,
      DateTime? date,
      String? selectedText,
      String? currentText}) {
    return AddPageState(
        title: title ?? this.title,
        entities: entities ?? this.entities,
        name: name ?? this.name,
        organization: organization ?? this.organization,
        inn: inn ?? this.inn,
        status: status ?? this.status,
        pageStatuses: pageStatuses ?? this.pageStatuses,
        errorMessage: errorMessage ?? this.errorMessage,
        date: date ?? this.date,
        selectedText: selectedText ?? this.selectedText,
        currentText: currentText ?? this.currentText);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    title,entities,name,organization,inn,status,pageStatuses,errorMessage,date,selectedText,currentText,selectedText,
  ];



}

enum PageStatuses { initial, loading, success, fail }
