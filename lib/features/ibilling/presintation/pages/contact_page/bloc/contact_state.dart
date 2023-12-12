part of 'contact_bloc.dart';

@immutable
class ContactState {
  final String errorMessage;
  final PageStatuses pageStatuses;
  final List<ContactModel> list;
  final bool chipChoiceEnum;

  const ContactState({
    this.errorMessage = "",
    this.pageStatuses = PageStatuses.initial,
    this.list = const [],
    this.chipChoiceEnum =true,
  });

  ContactState copyWith({
    String? errorMessage,
    PageStatuses? pageStatuses,
    List<ContactModel>? list,
    bool? chipChoiceEnum,
  }) {
    return ContactState(
        errorMessage: errorMessage ?? this.errorMessage,
        pageStatuses: pageStatuses ?? this.pageStatuses,
        list: list ?? this.list,
        chipChoiceEnum: chipChoiceEnum ?? this.chipChoiceEnum);
  }
}
