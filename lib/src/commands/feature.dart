import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:jet_cli/src/builders/data/remote/remote_datasource_builder.dart';
import 'package:jet_cli/src/builders/data/remote/remote_model_builder.dart';
import 'package:jet_cli/src/builders/data/repository/repository_impl_builder.dart';
import 'package:jet_cli/src/extensions/extensions.dart';
import 'package:jet_cli/src/utils/cli_utils.dart';
import 'package:jet_cli/src/variables/data/remote/remote_datasource_variables.dart';
import 'package:jet_cli/src/variables/data/remote/remote_model_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';
import 'package:recase/recase.dart';

class FeatureCommand extends Command<int> {
  FeatureCommand() {
    argParser.addOption('feature-name', help: 'The name of the feature');
  }

  @override
  String get description => 'Create a new feature';

  @override
  String get name => 'feature';

  @override
  String get invocation => 'jet feature <feature name singular>';

  @override
  Future<int> run() async {
    _validateFeatureName(argResults?.rest ?? []);

    // check if feature already exists

    final featureName = argResults!.rest[0].camelCase;

    final featureVariables = FeatureVariables();

    featureVariables.featureNameCapitalized = featureName.capitalized;

    featureVariables.singularNameForModel = featureName.capitalized;
    featureVariables.singularNameLowercase = featureName;

    // first we need to get all the variables that we need to generate all
    // the other parts

    // get the correct plural name
    final pluralName = plural(featureName).camelCase;
    featureVariables.featureName = pluralName;
    featureVariables.pluralName = pluralName.capitalized;
    featureVariables.pluralNameLowercase = pluralName;

    okContinue('singular $featureName, plural: $pluralName');

    featureVariables.hasDomainLayer = boolQuestion('Has domain layer? ');
    featureVariables.responseSingleObject =
        boolQuestion('Is response a single object?');

    if (featureVariables.responseSingleObject!) {
      featureVariables.modelNameLowercase =
          featureVariables.singularNameLowercase;
      featureVariables.modelNameCapitalized =
          featureVariables.singularNameForModel;
    } else {
      featureVariables.modelNameLowercase =
          featureVariables.pluralNameLowercase;
      featureVariables.modelNameCapitalized = featureVariables.pluralName;
    }

    print(featureVariables.toMap().toString());

    RemoteModelVariables? remoteModelVariables;

    if (boolQuestion('Generate remote model?', prefix: '\n🌐')) {
      remoteModelVariables = RemoteModelBuilder.build(featureVariables);
    }
    RemoteDatasourceVariables? remoteDatasourceVariables;

    if (boolQuestion('Generate remote datasource?', prefix: '\n🌐')) {
      remoteDatasourceVariables = RemoteDatasourceBuilder.build(
        featureVariables,
        remoteModelVariables: remoteModelVariables,
      );
    }

    if (boolQuestion('Generate repository? ', prefix: '\n📁')) {
      final repositoryImplVariables = RepositoryImplBuilder.build(
        featureVariables,
        remoteDatasourceVariables: remoteDatasourceVariables,
      );
    }

    //await Process.run('flutter', ['format', 'output']);

    return 0;
  }

  void _validateFeatureName(List<String> args) {
    if (args.isEmpty) {
      throw UsageException(
        'No option specified for the feature name.',
        usage,
      );
    }

    if (args.length > 1) {
      throw UsageException('Multiple feature names specified.', usage);
    }
  }
}
