import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/core/network/network_info.dart';
import 'package:momobill/features/trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:momobill/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:momobill/features/trivia/domain/entities/number_trivia.dart';
import 'package:momobill/features/trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    return await _getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(_ConcreteOrRandomChooser getConcreteOrRandomNumber) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandomNumber();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerErrorException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheErrorException {
        return Left(CacheFailure());
      }
    }
  }
}
