import 'package:dartz/dartz.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import '../../../../core/error/failures.dart';

abstract class IBillingRepository {
  Future<Either<Failure, bool>> addContact(
    String entities,
    String name,
    String organization,
    String inn,
    String status,
    DateTime date,
  );

  Future<Either<Failure, List<ContactModel>>> getContact(DateTime dateTime);

  Future<Either<Failure, List<ContactModel>>> getMoreContract(DateTime dateTime);

  Future<Either<Failure, List<ContactModel>>> getALLConracr();

  Future<Either<Failure, List<ContactModel>>> getSearchContractList(
      String search);

  Future<Either<Failure, bool>> deleteContractItem(String id);

  Future<Either<Failure, List<ContactModel>>> getSingleList(String name);

  Future<Either<Failure, bool>> updateSavedContractItem(
      String id, bool isSaved);
  Future<Either<Failure, List<ContactModel>>> getSavedList();
}
