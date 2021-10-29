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

String multilineInput(String question) {
  // TODO: make this dynamic
  // if (true) {
  //   return stringQuestion("input singleline");
  // }
  stdout.write('${"\t" * cli.currentLevel}❓ $question: ');

  final lines = [];

  String input;
  while (true) {
    input = stdin.readLineSync() ?? '';
    if (input.isNotEmpty) {
      lines.add(input);
    } else {
      break;
    }
  }

  return lines.join('\n');
}

String stringQuestion(String question, {String? defaultChoice}) {
  stdout.write('${"\t" * cli.currentLevel}❓ $question: ');
  if (defaultChoice != null) {
    stdout.write('[$defaultChoice] ');
  }

  String input = defaultChoice != null ? '\n' : '';
  while ((input == '\n' && defaultChoice != null) ||
      (input.isEmpty && defaultChoice == null)) {
    input = stdin.readLineSync() ?? '';
    stdout.write('\n');
  }

  if (cli.currentLevel > 0) cli.currentLevel--;

  if (input == '' && defaultChoice != null) {
    return defaultChoice;
  }

  return input;
}

bool boolQuestion(String message, {String? prefix}) {
  String input = '';

  while (input.isEmpty ||
      (input.toLowerCase() != 'y' && input.toLowerCase() != 'n')) {
    stdout
        .write('${"\t" * cli.currentLevel}${prefix ?? "❓"} $message [y][n]: ');
    stdin.echoMode = false;
    stdin.lineMode = false;

    input = utf8.decode([stdin.readByteSync()]);
    stdin.lineMode = true;
    stdin.echoMode = true;

    stdout.write('\n');
  }

  return input.toLowerCase() == 'y';
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

void finished({Duration? duration}) {
  stdout.writeln('🏁 Finished ${duration != null ? "in $duration" : ""}');
}

void generated(String name) {
  stdout.writeln('🙌 Generated $name');
}

void okContinue(String message) {
  stdout.writeln('✅ Ok, $message');
}
