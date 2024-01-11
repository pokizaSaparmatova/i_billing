import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';
import 'package:ibilling/features/ibilling/domain/usecases/add_contract.dart';

class GetSavedList implements UseCase<List<ContactModel>, NoParams> {
  final IBillingRepository repository;

  GetSavedList(this.repository);

  @override
  Future<Either<Failure, List<ContactModel>>> call(NoParams) async {
    print("usecaseee");
    return repository.getSavedList();
  }
}

