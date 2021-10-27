import 'dart:cli';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'dart:io';
import 'dart:convert';
@TestOn('vm')
import '../bin/jet_cli.dart' as jet;

void main() {
  test('generates todo feature correctly', () async {
    //stdin.echoMode = false;
    // stdin.lineMode = false;

    final process =
        await Process.start('dart', ['bin/jet_cli.dart', 'feature', 'Todo']);
    stdin.echoMode = false;
    stdin.lineMode = false;

    stdout.write('y');
    waitFor<void>(stdout.flush());
    process.stdin.write('y');
    // process.stdin.write('n');
    // process.stdin.write('y');
    // process.stdin.write('{"userId": 1}');
    // process.stdin.write('\n\n');

    final lineStream =
        process.stdout.transform(Utf8Decoder()).transform(LineSplitter());
    await for (final line in lineStream) {
      print(line);
    }
    //expect(actual, matcher)
  });
}
