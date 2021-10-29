import 'dart:convert';

import 'package:jet_cli/src/variables/parameter.dart';

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

  String? repositoryFilename;
  String? repositoryImplFilename;

  String? remoteModelFilename;
  String? remoteDatasourceFilename;
  String? domainModelFilename;

  String? packageName;

  List<Parameter>? params;
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
    this.repositoryFilename,
    this.remoteModelFilename,
    this.remoteDatasourceFilename,
    this.domainModelFilename,
    this.repositoryImplFilename,
    this.packageName,
    this.params,
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
      'modelNameCapitalized': modelNameCapitalized,
      'functionParams': functionParams,
      'declarationParams': declarationParams,
      'blocToRepository': blocToRepository,
      'repositoryToDatasource': repositoryToDatasource,
      'constParams': constParams,
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

  String get functionParams {
    if (params!.isEmpty) return '';

    final paramsList = params
        ?.map((p) =>
            '${p.required ? "required " : ""}${p.type}${p.required ? "" : "?"} ${p.name},')
        .join('');

    return '{$paramsList}';
  }

  String get constParams {
    if (params!.isEmpty) return '';
    final paramsList = params
        ?.map((p) => '${p.required ? "required " : ""}this.${p.name},')
        .join('');
    return '{$paramsList}';
  }

  String get declarationParams {
    if (params!.isEmpty) return '';
    final paramsList = params
        ?.map((p) => 'final ${p.type}${p.required ? "" : "?"} ${p.name};')
        .join('\n');
    return '$paramsList';
  }

  String get blocToRepository {
    if (params!.isEmpty) return '';
    final paramsList =
        params?.map((p) => '${p.name}: event.${p.name}').join(',');
    return '$paramsList';
  }

  String get repositoryToDatasource {
    if (params!.isEmpty) return '';
    final paramsList = params?.map((p) => '${p.name}: ${p.name}').join(',');
    return '$paramsList';
  }

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
