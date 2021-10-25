import 'dart:io';

import 'cli_utils.dart';

saveGeneratedContent(String file, String content) {
  // we need to find the appropriate directory to output the files
  final createdFile = File('output/$file');
  createdFile.createSync(recursive: true);
  createdFile.writeAsStringSync(content);

  generated(createdFile.path);
}

renamedFileWithPackage(String file) {
  return file;
}

renamedFile(String file, String newName, String featureName) {
  return file
      .replaceAll(
        '{{name}}',
        newName,
      )
      .replaceAll(
        '.jet',
        '.dart',
      )
      .replaceAll('feature', featureName)
      .toLowerCase();
}
