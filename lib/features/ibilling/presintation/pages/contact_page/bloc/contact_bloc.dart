import 'package:bloc/bloc.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_all_contracts.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_search_list.dart';
import 'package:ibilling/features/ibilling/domain/usecases/get_single_list_contract.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../data/datasource/local_datasource/local_datasource.dart';
import '../../../../data/models/contact_model.dart';
import '../../../../domain/usecases/get_contact.dart';
import '../../../../domain/usecases/get_next_contract.dart';
import '../../../../domain/usecases/remove_contract.dart';
import '../../../../domain/usecases/saved_contract.dart';
import 'package:rxdart/rxdart.dart';

part 'contact_event.dart';

part 'contact_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final GetContact getContactUsecase;
  final GetNextContract getNextContract;
  final GetSearchList getSearchList;
  List<ContactModel> newList = [];
  List<ContactModel> allContractList = [];
  final GetAllContract getAllContract;
  final RemoveContract removeContract;
  final GetSingleListContract getSingleListContract;
  final LocalDataSource localDataSource;
  final SavedContract savedContract;
  List<DateTime> dateList = [];

  ContactBloc({
    required this.getContactUsecase,
    required this.getNextContract,
    required this.getAllContract,
    required this.getSearchList,
    required this.removeContract,
    required this.getSingleListContract,
    required this.localDataSource,
    required this.savedContract,
  }) : super(ContactState()) {
    on<GetAllContractsEvent>((event, emit) async {
      print("blocccccc}");
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess =
          await getContactUsecase(DateParams(event.dateTime));
      failureOrSuccess.fold(
          (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))), (contact) async {
        newList = contact;
        print("newLISSSSSTTTTT:${newList.length}");
        emit(state.copyWith(
            pageStatuses: PageStatuses.success,
            list: newList,
            selectedDates: event.dateTime));
      });
    });
    on<ChangeChipChoiceEvent>((event, emit) async {
      print("ChangeChip}");
      emit(state.copyWith(chipChoiceEnum: event.chipChoiceEnum));
    });
    on<LoadMoreDataEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      print("loadMoreDatttaaaa}");

      final contractList =
          await getNextContract(DateTimeParams(event.dateTime));
      contractList.fold((l) => null, (nextList) async {
        newList.addAll(nextList);
        print("newList:${nextList}");
        emit(state.copyWith(
            pageStatuses: PageStatuses.success,
            list: newList,
            isLoading: false,
            total: allContractList.length));
      });
    });
    EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) =>
        (events, mapper) => events.debounceTime(duration).flatMap(mapper);
    on<GetSearchListEvent>((
      event,
      emit,
    ) async {
      print("SEACHHHHHHH}");
      List<ContactModel> searchList = [];
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess = await getAllContract(NoParams());
      failureOrSuccess.fold(
          (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))), (contact) async {
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
            list: searchList,
            search: event.search));
      });
    }, transformer: debounce(Duration(milliseconds: 300)));
    on<GetFilterListEvent>((event, emit) async {
      print("filterblocc}");
      String dateFormatted = "23.12.2023";

      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess = await getAllContract(NoParams());
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
          list: newList,
        ));
      });
    });
    on<DeleteContractEvent>((event, emit) async {
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess = await removeContract(RemoveParams(event.id));
      failureOrSuccess.fold(
          (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))), (contact) async {
        emit(state.copyWith(
          pageStatuses: PageStatuses.success,
        ));
      });
    });
    on<GetSingleListContractEvent>((event, emit) async {
      emit(state.copyWith(pageStatuses: PageStatuses.loading));
      final failureOrSuccess =
          await getSingleListContract(NameParams(event.name));
      failureOrSuccess.fold(
          (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))), (contact) async {
        emit(state.copyWith(pageStatuses: PageStatuses.success, list: contact));
      });
    });
    on<SavedContractEvent>((event, emit) async {
      print("savedddddddddddd");
      print("savedddddddddddd:${event.id}");
      print("savedddddddddddd:${event.isSaved}");

      final failureOrSuccess =
          await savedContract(SavedParams(event.id, event.isSaved));
      failureOrSuccess.fold(
          (failure) => emit(state.copyWith(
              pageStatuses: PageStatuses.fail,
              errorMessage: _mapFailureMessage(failure))), (contact) async {
        List<ContactModel> updatedList(
          List<ContactModel> contacts,
          String numberToUpdate,
        ) {
          return contacts.map((contact) {
            if (contact.number == event.id) {
              return ContactModel(
                  entity: contact.entity,
                  name: contact.name,
                  organization: contact.organization,
                  inn: contact.inn,
                  status: contact.status,
                  date: contact.date,
                  number: contact.number,
                  isSaved: event.isSaved);
            }
            return contact;
          }).toList();
        }

        emit(state.copyWith(
            pageStatuses: PageStatuses.success,
            list: updatedList(state.list, event.id)));
      });
    });
    on<AddWeekListEvent>((event, emit) async {
      if(!dateList.contains(event.currentDate)){
        dateList.add(event.currentDate);
        print("LLLL:${dateList}");
        print("LLL:${event.currentDate}");
        print("LL:${state.selectedDates}");
      }
      emit(state.copyWith(dateList: dateList));

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
