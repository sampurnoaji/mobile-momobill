import 'package:equatable/equatable.dart';

const String SERVER_FAILURE_MESSAGE = 'Kesalahan pada server';
const String CACHE_FAILURE_MESSAGE = 'Kesalahan pada database';
const String CONNECTION_FAILURE_MESSAGE = 'Masalah koneksi internet';
const String UNKNOWN_FAILURE_MESSAGE = 'Terjadi kesalahan pada aplikasi';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class ConnectionFailure extends Failure {}