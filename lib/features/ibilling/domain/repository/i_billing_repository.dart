import 'package:dartz/dartz.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';

import '../../../../core/error/failures.dart';

abstract class IBillingRepository {
  Future<Either<Failure, void>> addContact(String entities, String name,
      String organization, String inn, String status);
// Future<Either<Failure, Unit>> addInvoice();
}
