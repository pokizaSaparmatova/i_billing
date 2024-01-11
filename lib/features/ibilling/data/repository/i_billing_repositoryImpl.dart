import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ibilling/core/error/failures.dart';
import 'package:ibilling/features/ibilling/data/datasource/local_datasource/local_datasource.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';
import 'package:ibilling/features/ibilling/domain/repository/i_billing_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../dependency_injection.dart';

class IBillingRepositoryImpl extends IBillingRepository {
  final firestore = FirebaseFirestore.instance;
  final String collectionPath = 'contacts';
  var pref = sl<LocalDataSource>();
  int docNumber = 0;
  List<ContactModel> list = [];
  List<ContactModel> allContactList = [];

  @override
  Future<Either<Failure, bool>> addContact(String entities, String name,
      String organization, String inn, String status, DateTime date) async {
    final contactDate = ContactModel(
        entity: entities,
        name: name,
        organization: organization,
        inn: inn,
        status: status,
        isSaved: false,
        date: DateTime.timestamp(),
        number: "${++docNumber}");

    final collection = firestore.collection(collectionPath);
    docNumber = int.parse(contactDate.number);
    try {
      await collection.doc(contactDate.number).set({
        "entities": entities,
        "name": name,
        "organization": organization,
        "inn": inn,
        "status": status,
        "date": Timestamp.fromDate(date),
        'isSaved': pref.getBool(contactDate),
      });
      print("docNumberr:${docNumber}");
      return const Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getContact(DateTime dateTime) async {

    DateTime start = DateTime(dateTime.year, dateTime.month, dateTime.day);
    DateTime end = start.add(Duration(days: 1));

    Timestamp startTime = Timestamp.fromDate(start);
    Timestamp endTime = Timestamp.fromDate(end);

    try {
      var res = firestore
          .collection(collectionPath)
          .orderBy('date', descending: true)
          .where('date', isGreaterThanOrEqualTo: startTime)
          .where('date', isLessThanOrEqualTo: endTime)
          .limit(10);
      QuerySnapshot<Map<String, dynamic>> qShot = await res.get();
      final result = qShot.docs.map((doc) {
        int id = int.parse(doc.id);
        if (docNumber < id) {
          docNumber = id;
        }
        return ContactModel.fromJson(doc.data(), doc.id);
      }).toList();

      print('resulllllltttt:${result.length}');
      if(dateTime.weekday==7){
       result.clear();
        return Right(result);
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getMoreContract(DateTime dateTime) async {
    DateTime start = DateTime(dateTime.year, dateTime.month, dateTime.day);
    DateTime end = start.add(Duration(days: 1));

    Timestamp startTime = Timestamp.fromDate(start);
    Timestamp endTime = Timestamp.fromDate(end);
    try {
      var res = firestore
          .collection(collectionPath)
          .orderBy('date', descending: true)
          .where('date', isGreaterThanOrEqualTo: startTime)
          .where('date', isLessThanOrEqualTo: endTime)
          .limit(10);
      QuerySnapshot<Map<String, dynamic>> qShot = await res.get();

      if (qShot.docs.isEmpty) {
        // No more data to load
        return Right([]);
      }

      final lastVisible = qShot.docs[qShot.size - 1];
      final nextList = firestore
          .collection(collectionPath)
          .orderBy('date', descending: true)
          .where('date', isGreaterThanOrEqualTo: startTime)
          .where('date', isLessThanOrEqualTo: endTime)
          .startAfterDocument(lastVisible)
          .limit(10);

      QuerySnapshot<Map<String, dynamic>> qShot1 = await nextList.get();
      final result = qShot1.docs
          .map((doc) => ContactModel.fromJson(doc.data(), doc.id))
          .toList();
      print("loadMore: ${result.length}");

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getALLConracr() async {
    try {
      var res = firestore
          .collection(collectionPath)
          .orderBy('date', descending: true);
      QuerySnapshot<Map<String, dynamic>> qShot = await res.get();
      final result = qShot.docs
          .map((doc) => ContactModel.fromJson(doc.data(), doc.id))
          .toList();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getSearchContractList(
      String search) async {
    try {
      var res = firestore
          .collection(collectionPath)
          .orderBy("name")
          .where("name", isEqualTo: search);
      QuerySnapshot<Map<String, dynamic>> qShot = await res.get();
      final result = qShot.docs
          .map((doc) => ContactModel.fromJson(doc.data(), doc.id))
          .toList();
      print("repoLISTTTTT:${result.length}");
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteContractItem(String id) async {
    var collection = firestore.collection(collectionPath);
    try {
      await collection.doc(id).delete();
      print("deleteRepo");
      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getSingleList(String name) async {
    try {
      var res = firestore
          .collection(collectionPath)
          .orderBy("name")
          .where("name", isEqualTo: name);
      QuerySnapshot<Map<String, dynamic>> qShot = await res.get();
      final result = qShot.docs
          .map((doc) => ContactModel.fromJson(doc.data(), doc.id))
          .toList();
      print("repoLISTTTTT:${result.length}");
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateSavedContractItem(
      String id, bool isSaved) async {
    final collection = firestore.collection(collectionPath);
    try {
      await collection.doc(id).update({'isSaved': isSaved});
      print("isSavedREpo");
      return const Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getSavedList() async {
    try {
      var res = firestore
          .collection(collectionPath)
          .orderBy("isSaved")
          .where("isSaved", isEqualTo: true);
      QuerySnapshot<Map<String, dynamic>> qShot = await res.get();
      final result = qShot.docs
          .map((doc) => ContactModel.fromJson(doc.data(), doc.id))
          .toList();
      print("repoLISTTTTTSaved:${result.length}");
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
