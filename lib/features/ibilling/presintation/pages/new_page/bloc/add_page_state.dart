part of 'add_page_bloc.dart';

@immutable
class AddPageState extends Equatable {
  final String title;

  const AddPageState({ this.title=""});

  AddPageState copyWith(String? title) {
    return AddPageState(title: title ?? this.title);
  }

  @override
  List<Object?> get props => [title];
}
