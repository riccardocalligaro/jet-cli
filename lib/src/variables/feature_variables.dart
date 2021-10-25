import 'dart:convert';

class FeatureVariables {
  String? featureName;

  String? singularNameForModel;
  String? singularNameLowercase;

  String? pluralName;
  String? pluralNameLowercase;

  String? featureNameCapitalized;

  bool? hasDomainLayer;
  bool? responseSingleObject;

  String? modelNameLowercase;
  String? modelNameCapitalized;

  FeatureVariables({
    this.featureName,
    this.singularNameForModel,
    this.singularNameLowercase,
    this.pluralName,
    this.pluralNameLowercase,
    this.featureNameCapitalized,
    this.hasDomainLayer,
    this.responseSingleObject,
    this.modelNameLowercase,
    this.modelNameCapitalized,
  });

  Map<String, dynamic> toMap() {
    return {
      'featureName': featureName,
      'singularNameForModel': singularNameForModel,
      'singularNameLowercase': singularNameLowercase,
      'pluralName': pluralName,
      'pluralNameLowercase': pluralNameLowercase,
      'featureNameCapitalized': featureNameCapitalized,
      'hasDomainLayer': hasDomainLayer,
      'responseSingleObject': responseSingleObject,
      'returnModel': returnModel,
      'modelNameLowercase': modelNameLowercase,
      'modelNameCapitalized': modelNameCapitalized
    };
  }

  factory FeatureVariables.fromMap(Map<String, dynamic> map) {
    return FeatureVariables(
      featureName: map['featureName'],
      singularNameForModel: map['singularNameForModel'],
      singularNameLowercase: map['singularNameLowercase'],
      pluralName: map['pluralName'],
      pluralNameLowercase: map['pluralNameLowercase'],
      featureNameCapitalized: map['featureNameCapitalized'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeatureVariables.fromJson(String source) =>
      FeatureVariables.fromMap(json.decode(source));

  String get returnModel {
    String modelName = '';
    if (hasDomainLayer!) {
      modelName = '${singularNameForModel}DomainModel';
    } else {
      modelName = '${singularNameForModel}RemoteModel';
    }

    if (responseSingleObject!) {
      return modelName;
    } else {
      return 'List<$modelName>';
    }
  }
}
