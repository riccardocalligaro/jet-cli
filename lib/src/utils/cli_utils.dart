import 'dart:async';
import 'dart:convert';

import 'package:jet_cli/jet_cli.dart';
import 'package:jet_cli/src/extensions/string_extensions.dart';
import 'package:universal_io/io.dart';

Timer loadingAnimation({
  String? suffix,
}) {
  var p = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'];
  var x = 0;

  return Timer.periodic(Duration(milliseconds: 250), (timer) {
    stdout.write("\r" + p[x++] + ' $suffix');
    x &= 3;
  });
}

void buildMessage(String message) => stdout.writeln('🔨 $message');

String stringQuestion(String question) {
  stdout.write('${"\t" * cli.currentLevel}❓ $question: ');
  String input = '';
  while (input.isEmpty) {
    input = stdin.readLineSync() ?? '';
    stdout.write('\n');
  }

  if (cli.currentLevel > 0) cli.currentLevel--;

  return input;
}

bool boolQuestion(String message, {String? prefix}) {
  String input = '';

  while (input.isEmpty || (input != 'y' && input != 'n')) {
    stdout.write('${prefix ?? "❓"} $message [y][n]: ');
    stdin.lineMode = false;
    input = utf8.decode([stdin.readByteSync()]);
    stdin.lineMode = true;
    stdout.write('\n');
  }

  return input == 'y';
}

String plural(String featureName) {
  final plural = featureName.plural.capitalized;
  if (boolQuestion('Is plural [$plural] correct?: ')) {
    return plural;
  } else {
    cli.currentLevel++;
    return stringQuestion('Enter the correct name: ');
  }
}

void generated(String name) {
  stdout.writeln('🙌 Generated $name');
}

void okContinue(String message) {
  stdout.writeln('✅ Ok, $message');
}
