import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import '../../../../core/error/failures.dart';

abstract class IBillingRepository {
  Future<Either<Failure, bool>> addContact(String entities, String name,
      String organization, String inn, String status,DateTime date,);
    Future<Either<Failure, List<ContactModel>>> getContact();
// Future<Either<Failure, Unit>> addInvoice();
}
