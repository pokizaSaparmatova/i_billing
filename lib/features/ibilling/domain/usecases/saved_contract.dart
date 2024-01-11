import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/core/usecase/usecase.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';
import 'package:ibilling/features/ibilling/domain/entities/contact.dart';
import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';

class SavedContract implements UseCase<void, SavedParams> {
  final IBillingRepository repository;

  SavedContract(this.repository);

  @override
  Future<Either<Failure, void>> call(SavedParams params) async {

    return await repository.updateSavedContractItem(params.id,params.isSaved);
  }


}

class SavedParams extends Equatable {
  final String id;
  final bool isSaved;


  const SavedParams(this.id,this.isSaved);

  @override
  List<Object> get props => [id,isSaved];
}
