import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/core/utils/enums/chip_choice_enum.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../data/models/contact_model.dart';
import '../../../../domain/usecases/get_contact.dart';

part 'contact_event.dart';

part 'contact_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final GetContact getContactUsecase;

  ContactBloc({required this.getContactUsecase}) : super(const ContactState()) {
    on<GetAllContractsEvent>((event, emit) async {
      print("blocccccc}");
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess = await getContactUsecase(NoParams());
      failureOrSuccess.fold(
              (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))),
              (contact) async =>
              emit(state.copyWith(pageStatuses: PageStatuses.success,list: contact)));
    });
    on<ChangeChipChoiceEvent>((event, emit) async {
      print("ChangeChip}");
      emit(state.copyWith(chipChoiceEnum: event.chipChoiceEnum));
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
