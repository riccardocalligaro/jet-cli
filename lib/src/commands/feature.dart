import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:jet_cli/src/builders/container_builder.dart';
import 'package:jet_cli/src/builders/data/remote/remote_datasource_builder.dart';
import 'package:jet_cli/src/builders/data/remote/remote_model_builder.dart';
import 'package:jet_cli/src/builders/data/repository/repository_impl_builder.dart';
import 'package:jet_cli/src/builders/domain/model/domain_model_builder.dart';
import 'package:jet_cli/src/builders/domain/repository/repository_builder.dart';
import 'package:jet_cli/src/builders/presentation/bloc/bloc_builder.dart';
import 'package:jet_cli/src/builders/presentation/page_builder.dart';
import 'package:jet_cli/src/extensions/extensions.dart';
import 'package:jet_cli/src/utils/cli_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/data/remote/remote_datasource_variables.dart';
import 'package:jet_cli/src/variables/data/remote/remote_model_variables.dart';
import 'package:jet_cli/src/variables/data/repository/repository_impl_variables.dart';
import 'package:jet_cli/src/variables/domain/model/domain_model_variables.dart';
import 'package:jet_cli/src/variables/domain/repository/repository_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';
import 'package:jet_cli/src/variables/presentation/bloc_variables.dart';
import 'package:recase/recase.dart';
import 'package:universal_io/prefer_universal/io.dart';

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
    final stopwatch = Stopwatch()..start();

    //stdout.flush();
    _validateFeatureName(argResults?.rest ?? []);

    // check if feature already exists

    final config = loadConfig();

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

    if (config['package_name'] == null) {
      featureVariables.packageName = stringQuestion('Package name');
    } else {
      featureVariables.packageName = config['package_name'];
    }

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

    RemoteModelVariables? remoteModelVariables;
    RepositoryVariables? repositoryVariables;
    RepositoryImplVariables? repositoryImplVariables;
    DomainModelVariables? domainModelVariables;
    BlocVariables? blocVariables;

    if (boolQuestion('Generate remote model?', prefix: '\n🌐')) {
      remoteModelVariables = RemoteModelBuilder.build(featureVariables);
      featureVariables.remoteModelFilename = remoteModelVariables.filename;
    }
    RemoteDatasourceVariables? remoteDatasourceVariables;

    if (boolQuestion('Generate remote datasource?', prefix: '\n🌐')) {
      remoteDatasourceVariables = RemoteDatasourceBuilder.build(
        featureVariables,
        remoteModelVariables: remoteModelVariables,
      );

      featureVariables.remoteDatasourceFilename =
          remoteDatasourceVariables.filename;
    }

    if (boolQuestion('Generate repository? ', prefix: '\n📁')) {
      if (featureVariables.hasDomainLayer ?? false) {
        domainModelVariables = DomainModelBuilder.build(
          featureVariables,
          remoteModelVariables,
        );

        featureVariables.domainModelFilename = domainModelVariables.filename;

        repositoryVariables = RepositoryBuilder.build(
          featureVariables,
        );

        featureVariables.repositoryFilename = repositoryVariables.filename;
      }

      repositoryImplVariables = RepositoryImplBuilder.build(
        featureVariables,
        remoteDatasourceVariables: remoteDatasourceVariables,
      );

      featureVariables.repositoryImplFilename =
          repositoryImplVariables.filename;
    }

    if (boolQuestion('Generate BloC? ', prefix: '\n🌊')) {
      blocVariables = BlocBuilder.build(
        featureVariables,
        repositoryImplVariables: repositoryImplVariables,
        repositoryVariables: repositoryVariables,
      );
    }

    if (boolQuestion('Generate page presentation?', prefix: '\n🌇')) {
      PageBuilder.build(
        featureVariables,
        blocVariables: blocVariables,
        domainModelVariables: domainModelVariables,
      );
    }

    if (boolQuestion('Generate container?', prefix: '\n📦')) {
      ContainerBuilder.build(
        featureVariables,
      );
    }

    await Process.run('cd', ['.\\output']);
    await Process.run('flutter', ['format', '.']);

    stdout.write('\n');
    finished(duration: stopwatch.elapsed);
    stopwatch.stop();
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
