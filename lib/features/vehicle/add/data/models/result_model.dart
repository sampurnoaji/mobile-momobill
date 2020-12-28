import 'package:momobill/features/vehicle/add/domain/models/result.dart';

class ResultsModel extends Result{
  final List<ResultModel> results;

  ResultsModel({this.results});

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<ResultModel> results =
        list.map((e) => ResultModel.fromJson(e)).toList();
    return ResultsModel(results: results);
  }
}

class ResultModel {
  final String description;

  ResultModel({this.description});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(description: json['description']);
  }
}

extension ResultsModelExtension on ResultsModel {
  get toDomainModel {
    List<Result> results = [];
    this.results.forEach((element) {
      results.add(Result(description: element.description));
    });
    return results;
  }
}
