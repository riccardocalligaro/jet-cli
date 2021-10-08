import 'package:args/command_runner.dart';
import 'package:jet_cli/src/commands/feature.dart';

class JetCommandRunner extends CommandRunner<int> {
  JetCommandRunner() : super('jet', '🚀 A super fast and easy CLI') {
    argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the current version.',
    );
    addCommand(FeatureCommand());
  }
}
