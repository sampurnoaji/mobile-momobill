import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/features/trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}