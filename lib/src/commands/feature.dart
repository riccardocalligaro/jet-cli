import 'package:args/command_runner.dart';

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

    final featureName = argResults!.rest[0];
    print('Creating feature $featureName');

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
