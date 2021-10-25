import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:jet_cli/src/json_to_model/index.dart';
import 'package:jet_cli/src/json_to_model/models/json_options.dart';
import 'package:jet_cli/src/utils/cli_utils.dart';
import 'package:recase/recase.dart';
import 'package:jet_cli/src/extensions/extensions.dart';

class ModelCommand extends Command<int> {
  FeatureCommand() {
    argParser.addOption('model-name', help: 'The name of the model');
  }

  @override
  String get description => 'Create a new model';

  @override
  String get name => 'model';

  @override
  String get invocation => 'jet model <model name>';

  @override
  Future<int> run() async {
    final titleCaseModelName = argResults!.rest[0].camelCase.capitalized;

    okContinue('creating $titleCaseModelName');

    final input = multilineInput("Insert model JSON");

    JsonModelGenerator.run(
      JSONOptions(
        name: titleCaseModelName,
        content: input,
      ),
    );

    return 0;
  }
}
