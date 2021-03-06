import 'dart:convert';

import 'package:jet_cli/src/variables/feature_variables.dart';

class RepositoryImplVariables {
  String? repositoryName;
  String? abstractRepositoryName;
  String? filename;
  String? returnType;
  String? imports;
  String? repositoryNameLowercase;
  String? usedRepository;

  RepositoryImplVariables({
    this.repositoryName,
    this.abstractRepositoryName,
    this.filename,
    this.returnType,
    this.imports,
    this.repositoryNameLowercase,
    this.usedRepository,
  });

  Map<String, dynamic> toMap(FeatureVariables featureVariables) {
    return {
      'repositoryName': repositoryName,
      'abstractRepositoryName': abstractRepositoryName,
      'filename': filename,
      'returnType': returnType,
      'imports': imports,
      'repositoryNameLowercase': repositoryNameLowercase,
      'usedRepository': usedRepository,
    }..addAll(featureVariables.toMap());
  }

  factory RepositoryImplVariables.fromMap(Map<String, dynamic> map) {
    return RepositoryImplVariables(
      repositoryName: map['repositoryName'],
      abstractRepositoryName: map['abstractRepositoryName'],
    );
  }

  String toJson(FeatureVariables featureVariables) =>
      json.encode(toMap(featureVariables));

  factory RepositoryImplVariables.fromJson(String source) =>
      RepositoryImplVariables.fromMap(json.decode(source));
}
