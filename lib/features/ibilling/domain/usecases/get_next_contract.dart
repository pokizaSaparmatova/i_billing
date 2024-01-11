import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';

class GetNextContract implements UseCase<List<ContactModel>, DateTimeParams> {
  final IBillingRepository repository;

  GetNextContract(this.repository);

  @override
  Future<Either<Failure, List<ContactModel>>> call(DateTimeParams params) {
    print("usecaseee");

    return repository.getMoreContract(params.date);
  }

}
class DateTimeParams extends Equatable {
  final DateTime date;


  DateTimeParams(this.date);

  @override
  List<Object> get props => [date];
}
