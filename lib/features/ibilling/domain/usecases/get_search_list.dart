import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';
import 'package:ibilling/features/ibilling/domain/usecases/add_contract.dart';

class GetSearchList implements UseCase<List<ContactModel>, Params> {
  final IBillingRepository repository;

  GetSearchList(this.repository);

  @override
  Future<Either<Failure, List<ContactModel>>> call(Params params) async {
    print("usecaseee");
    return repository.getSearchContractList(params.search);
  }
}

class Params extends Equatable {
  final String search;

  const Params(this.search);

  @override
  List<Object?> get props => [search];
}
