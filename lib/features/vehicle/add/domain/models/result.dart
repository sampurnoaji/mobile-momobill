import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final String description;

  Result({this.description});

  @override
  List<Object> get props => [description];
}
