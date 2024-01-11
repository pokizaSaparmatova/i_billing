import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../data/models/contact_model.dart';
import '../../../../domain/usecases/get_all_contracts.dart';
import '../../../../domain/usecases/get_saved_list.dart';
import '../../new_page/bloc/add_page_bloc.dart';

part 'saved_event.dart';

part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final GetSavedList getSavedList;
  final GetAllContract getAllContract;

  SavedBloc({required this.getSavedList, required this.getAllContract})
      : super(SavedState()) {
    on<GetSavedListEvent>((event, emit) async {
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess = await getSavedList(NoParams());
      failureOrSuccess.fold(
          (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))), (contact) async {
        print("savedList:${contact}");
        emit(state.copyWith(
            pageStatuses: PageStatuses.success, savedList: contact));
      });
    });
    on<GetSearchSavedListEvent>((event, emit) async {
      print("SEACHHHHHHH}");
      List<ContactModel> searchList = [];
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess = await getSavedList(NoParams());
      failureOrSuccess.fold(
          (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))), (contact) async {
            print("saveeeeeeee:${contact.length}");
        if (contact.isNotEmpty) {
          for (int i = 0; i < contact.length; i++) {
            if (contact[i]
                .name
                .toLowerCase()
                .contains(event.search.toLowerCase())) {
              searchList.add(contact[i]);
            }
          }
        }
        print("newLISSSSSTTTTT:${contact.length}");
        emit(state.copyWith(
            pageStatuses: PageStatuses.success,
            savedList: searchList,
            search: event.search));
      });
    });
    on<GetFilterSavedListEvent>((event, emit) async {
      print("filterblocc}");
      List<ContactModel> newList=[];
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess = await getSavedList(NoParams());
      failureOrSuccess.fold(
              (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))), (contact) async {
        newList = contact
            .where((contactItem) =>
        event.enumList
            .any((status) => contactItem.status.contains(status)) &&
            contactItem.date.isAfter(event.startDate) &&
            contactItem.date.isBefore(event.endDate))
            .toList();

        print('eventList:${event.enumList}');
        print("date:${event.endDate}");
        print("date:${event.startDate}");
        print("filterLISSSSSTTTTT:${newList.length}");
        emit(state.copyWith(
          pageStatuses: PageStatuses.success,
          savedList: newList,
        ));
      });
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
}
