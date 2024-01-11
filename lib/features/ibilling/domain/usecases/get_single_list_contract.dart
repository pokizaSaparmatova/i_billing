import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';
import 'package:ibilling/features/ibilling/domain/usecases/add_contract.dart';

class GetSingleListContract implements UseCase<List<ContactModel>, NameParams> {
  final IBillingRepository repository;

  GetSingleListContract(this.repository);

  @override
  Future<Either<Failure, List<ContactModel>>> call(NameParams params) async {
    print("usecaseee");
    return repository.getSearchContractList(params.name);
  }
}

class NameParams extends Equatable {
  final String name;

  const NameParams(this.name);

  @override
  List<Object?> get props => [name];
}
