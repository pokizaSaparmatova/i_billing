import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];

   Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
