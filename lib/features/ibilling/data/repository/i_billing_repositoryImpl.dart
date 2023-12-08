import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ibilling/core/error/exceptions.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';
import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';

class IBillingRepositoryImpl extends IBillingRepository {
  final firestore = FirebaseFirestore.instance;
  final String collectionPath = 'contacts';

  @override
  Future<Either<Failure, void>> addContact(String entities, String name,
      String organization, String inn, String status) async {
    try {
      final result = await firestore.collection(collectionPath);
      result.add({
        "entity": entities,
        "name": name,
        "organization": organization,
        "inn": inn,
        "status": status
      });
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}


