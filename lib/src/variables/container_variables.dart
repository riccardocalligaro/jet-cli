import 'dart:convert';

import 'package:jet_cli/src/variables/feature_variables.dart';

class ContainerVariables {
  String? filename;
  String? imports;

  ContainerVariables({
    this.filename,
    this.imports,
  });

  Map<String, dynamic> toMap(FeatureVariables featureVariables) {
    return {
      'filename': filename,
      'containerImports': imports,
    }..addAll(featureVariables.toMap());
  }

  factory ContainerVariables.fromMap(Map<String, dynamic> map) {
    return ContainerVariables(
      filename: map['filename'] != null ? map['filename'] : null,
    );
  }

  factory ContainerVariables.fromJson(String source) =>
      ContainerVariables.fromMap(json.decode(source));
}
