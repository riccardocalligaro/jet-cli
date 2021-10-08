import 'package:jet_cli/src/command_runner.dart';
import 'package:universal_io/io.dart';

const kDebugMode = true;
Future<void> main(List<String> args) async {
  if (kDebugMode) {
    // delete output
  }
  final status = await JetCommandRunner().run(args);
  await _flushThenExit(status ?? 0);
}

Future _flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()])
      .then<void>((_) => exit(status));
}
