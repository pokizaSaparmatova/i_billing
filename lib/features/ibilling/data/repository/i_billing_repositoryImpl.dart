import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/features/ibilling/data/datasource/local_datasource/local_datasource.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';
import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../dependency_injection.dart';

class IBillingRepositoryImpl extends IBillingRepository {
  final firestore = FirebaseFirestore.instance;
  final String collectionPath = 'contacts';
 var pref=sl<LocalDataSource>();
  int docNumber = 0;
  List<ContactModel>list=[];
  @override
  Future<Either<Failure, bool>> addContact(String entities, String name,
      String organization, String inn, String status, DateTime date) async {
    final contactDate = ContactModel(
        entity: entities,
        name: name,
        organization: organization,
        inn: inn,
        status: status,
        date: Timestamp.fromDate(date),
        number: "${++docNumber}");
    pref.saveNumber( "${++docNumber}");
    print("shareddddddddddd:${pref.getNumber()}");
    final collection = firestore.collection(collectionPath);
    docNumber=int.parse(contactDate.number);
    try {
      await collection.doc("${contactDate.number}").set({
        "entities": entities,
        "name": name,
        "organization": organization,
        "inn": inn,
        "status": status,
        "date": Timestamp.fromDate(date)
      });
      print("dateeeeee:${Timestamp.fromDate(date).toString()}");

      return const Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getContact() async {
    // QuerySnapshot<Map<String, dynamic>> querySnapshot =
    // await firestore.collection(collectionPath).snapshots();
    final collection = firestore.collection(collectionPath);
    try {
      QuerySnapshot<Map<String,dynamic>> qShot =
      await firestore.collection(collectionPath).get();
      final result= qShot.docs.map((doc) => ContactModel.fromJson(doc.data(),docNumber.toString())).toList();
print("numberrrrrrrrrrrrrrrrrrr:${docNumber}");
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
