import 'package:dartz/dartz.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';

class GetAllContract implements UseCase<List<ContactModel>, NoParams> {
  final IBillingRepository repository;

  GetAllContract(this.repository);

  @override
  Future<Either<Failure, List<ContactModel>>> call(NoParams params) {
    print("usecaseee");

    return repository.getALLConracr();
  }


}