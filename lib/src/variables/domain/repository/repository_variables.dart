import 'dart:convert';

import 'package:jet_cli/src/variables/feature_variables.dart';

class RepositoryVariables {
  String? filename;
  String? abstractRepositoryName;
  String? imports;

  RepositoryVariables({
    this.filename,
    this.imports,
    this.abstractRepositoryName,
  });

  Map<String, dynamic> toMap(FeatureVariables featureVariables) {
    return {
      'filename': filename,
      'imports': imports,
      'abstractRepositoryName': abstractRepositoryName,
    }..addAll(featureVariables.toMap());
  }

  factory RepositoryVariables.fromMap(Map<String, dynamic> map) {
    return RepositoryVariables(
      filename: map['filename'],
      imports: map['imports'],
    );
  }

  String toJson(FeatureVariables featureVariables) =>
      json.encode(toMap(featureVariables));

  factory RepositoryVariables.fromJson(String source) =>
      RepositoryVariables.fromMap(json.decode(source));
}
