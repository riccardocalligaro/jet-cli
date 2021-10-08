import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:jet_cli/src/builders/data/remote/remote_datasource_builder.dart';
import 'package:jet_cli/src/builders/data/remote/remote_model_builder.dart';
import 'package:jet_cli/src/utils/cli_utils.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';
import 'package:jinja/jinja.dart';
import 'package:jinja/loaders.dart';
import 'package:universal_io/io.dart';
import 'package:jet_cli/src/extensions/extensions.dart';
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

    final featureName = argResults!.rest[0].camelCase;

    final featureVariables = FeatureVariables();

    featureVariables.featureNameCapitalized = featureName.capitalized;
    featureVariables.featureName = featureName;

    featureVariables.singularNameForModel = featureName.capitalized;
    featureVariables.singularNameLowercase = featureName;

    // first we need to get all the variables that we need to generate all
    // the other parts

    // get the correct plural name
    final pluralName = plural(featureName).camelCase;

    featureVariables.pluralName = pluralName.capitalized;
    featureVariables.pluralNameLowercase = pluralName;

    okContinue('singular $featureName, plural: $pluralName');

    if (boolQuestion('Generate remote model?', prefix: '\n🌐')) {
      final remoteModelVariables = RemoteModelBuilder.build(featureVariables);
    }

    if (boolQuestion('Generate remote datasource?', prefix: '\n🌐')) {
      final remoteModelVariables =
          RemoteDatasourceBuilder.build(featureVariables);
    }

    var path = Platform.script.resolve('templates').toFilePath();

    final env = Environment(
      loader: FileSystemLoader(path: path),
      leftStripBlocks: true,
      trimBlocks: true,
    );

    final template = env
        .getTemplate('feature/data/remote/{{ feature }}_remote_datasource.jet');

    // String pluralName = '${featureName}s';

    //print(template.render(variables));

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
