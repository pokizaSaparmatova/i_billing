
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'add_page_event.dart';
part 'add_page_state.dart';

class AddPageBloc extends Bloc<AddPageEvent, AddPageState> {
  AddPageBloc() : super(AddPageState())  {
    on<AddContactInitialEvent>((event, emit) async {
      emit(state.copyWith(event.title));
      print("titleeee:${state.title}");
    });
    on<AddInvoiceInitialEvent>((event, emit) async{
      emit(state.copyWith(event.title));
      print("titleeee:${state.title}");
    });
  }
}
