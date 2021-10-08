import 'dart:io';

import 'cli_utils.dart';

saveGeneratedContent(String file, String content) {
  final createdFile = File('output/$file');
  createdFile.createSync(recursive: true);
  createdFile.writeAsStringSync(content);

  generated(createdFile.path);
}

renamedFile(String file, String newName) {
  return file
      .replaceAll(
        '{{name}}',
        newName,
      )
      .replaceAll(
        '.jet',
        '.dart',
      )
      .toLowerCase();
}
