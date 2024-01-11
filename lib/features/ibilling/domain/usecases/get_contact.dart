import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';

class GetContact implements UseCase<List<ContactModel>, DateParams> {
  final IBillingRepository repository;

  GetContact(this.repository);

  @override
  Future<Either<Failure, List<ContactModel>>> call(DateParams params) {
 print("usecaseee");

 return repository.getContact(params.date);
  }


}
class DateParams extends Equatable {
  final DateTime date;


  DateParams(this.date);

  @override
  List<Object> get props => [date];
}


