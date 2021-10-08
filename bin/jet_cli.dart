import 'package:jet_cli/src/command_runner.dart';
import 'package:universal_io/io.dart';

Future<void> main(List<String> args) async {
  final status = await JetCommandRunner().run(args);
  await _flushThenExit(status ?? 0);
}

Future _flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()])
      .then<void>((_) => exit(status));
}
