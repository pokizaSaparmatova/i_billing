

import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../domain/usecases/add_contract.dart';
import '../../../../domain/usecases/get_contact.dart';

part 'add_page_event.dart';
part 'add_page_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class AddPageBloc extends Bloc<AddPageEvent, AddPageState> {
  final CrudContact usecase;


  AddPageBloc({required this.usecase}) : super(AddPageState()) {
    on<AddContactInitialEvent>((event, emit) async {
      emit(state.copyWith(title: event.title));
      print("titleeee:${state.title}");
    });
    on<InitialEvent>((event, emit) async {
      emit(state.copyWith(title: event.title));

    });

    on<AddInvoiceInitialEvent>((event, emit) async {
      emit(state.copyWith(title: event.title));
      print("titleeee:${state.title}");
    });
    on<AddContactEvent>((event, emit) async {
      print("blocccccc:${event.inn}");
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess = await usecase(Params(event.name, event.entities,
          event.organization, event.inn, event.status,event.date));

      failureOrSuccess.fold(
          (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))),
          (contact){
            emit(state.copyWith(pageStatuses: PageStatuses.success));
            event.onSuccess();
          });
    });
    on<SetInitialStateEvent>((event, emit) async {
      emit(state.copyWith(pageStatuses: PageStatuses.initial));
      print("titleeee:${state.title}");
    });
    on<ClearStateEvent>((event, emit) async {
      emit(state.copyWith(entities: "",organization: "",name:"",inn: "",status: "",));
      print("titleeee:${state.entities}");
    });


  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Aniqlanmagan Xatolik';
    }
  }

// void _eitherLoadedOrErrorState(Emitter<AddPageState> emit,
//     AddPageState state,
//     Either<Failure, void> failureOrSuccess) async {
//   failureOrSuccess.fold(
//         (failure) async =>
//         emit(state.copyWith(
//             pageStatuses: PageStatuses.fail,
//             errorMessage: _mapFailureMessage(failure))),
//         (contact) async =>
//         emit(state.copyWith(
//             pageStatuses: PageStatuses.success,
//             entities
//             :,
//             name: contact.name,
//             organization: contact.organization,
//             inn: contact.inn,
//             status: contact.status
//         )),
//   );
}
