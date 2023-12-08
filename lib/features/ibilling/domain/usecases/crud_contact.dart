import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';
import 'package:ibilling/features/ibilling/domain/entities/contact.dart';
import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';

class CrudContact implements UseCase<void, Params> {
  final IBillingRepository repository;

  CrudContact(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.addContact(params.entities, params.name,
        params.organization, params.inn, params.status);
  }
}

class Params extends Equatable {
  final String entities;
  final String name;
  final String organization;
  final String inn;
  final String status;

  Params(this.entities, this.name, this.organization, this.inn, this.status);

  @override
  List<Object> get props => [entities, name, organization, inn, status];
}
