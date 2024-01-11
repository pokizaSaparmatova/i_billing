import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';
import 'package:ibilling/features/ibilling/domain/entities/contact.dart';
import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';

class RemoveContract implements UseCase<void, RemoveParams> {
  final IBillingRepository repository;

  RemoveContract(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveParams params) async {

    return await repository.deleteContractItem(params.id);
  }


}

class RemoveParams extends Equatable {
  final String id;


  const RemoveParams(this.id);

  @override
  List<Object> get props => [id];
}
