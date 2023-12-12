part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}
class ChangeChipChoiceEvent extends ContactEvent{
 final bool chipChoiceEnum;
 ChangeChipChoiceEvent(this.chipChoiceEnum);
}
class GetAllContractsEvent extends ContactEvent{

}
