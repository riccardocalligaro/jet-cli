import 'dart:convert';

import 'package:jet_cli/src/variables/feature_variables.dart';

class RemoteDatasourceVariables {
  String? name;
  String? remoteModel;
  String? path;
  String? imports;
  bool? generate;
  String? filename;

  RemoteDatasourceVariables({
    this.name,
    this.remoteModel,
    this.path,
    this.generate,
    this.imports,
  });

  Map<String, dynamic> toMap(FeatureVariables baseVariables) {
    return {
      'name': name,
      'remoteModel': remoteModel,
      'path': path,
      'generate': generate,
      'imports': imports,
    }..addAll(baseVariables.toMap());
  }

  factory RemoteDatasourceVariables.fromMap(Map<String, dynamic> map) {
    return RemoteDatasourceVariables(
      remoteModel: map['remoteModel'],
      path: map['path'],
      generate: map['generate'],
      imports: map['imports'],
    );
  }

  String toJson(FeatureVariables featureVariables) =>
      json.encode(toMap(featureVariables));

  factory RemoteDatasourceVariables.fromJson(String source) =>
      RemoteDatasourceVariables.fromMap(json.decode(source));
}
