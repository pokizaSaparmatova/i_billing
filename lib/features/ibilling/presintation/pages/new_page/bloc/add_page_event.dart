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
