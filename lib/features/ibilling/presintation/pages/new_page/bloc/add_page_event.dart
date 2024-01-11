part of 'add_page_bloc.dart';

@immutable
abstract class AddPageEvent {}

class AddContactInitialEvent extends AddPageEvent {
  final String title;

  AddContactInitialEvent(this.title);
}

class AddInvoiceInitialEvent extends AddPageEvent {
  final String title;

  AddInvoiceInitialEvent(this.title);
}

class AddContactEvent extends AddPageEvent {
  final String entities;
  final String name;
  final String organization;
  final String inn;
  final String status;
  final DateTime date;
  final VoidCallback onSuccess;


  AddContactEvent(
      {required this.entities,
      required this.name,
      required this.organization,
      required this.inn,
      required this.status,
      required this.date,required this.onSuccess});
}

class InitialEvent extends AddPageEvent {
  final String title;

  InitialEvent(this.title);
}

class SetInitialStateEvent extends AddPageEvent {
  final String title;

  SetInitialStateEvent(this.title);
}

class ClearStateEvent extends AddPageEvent {


}
