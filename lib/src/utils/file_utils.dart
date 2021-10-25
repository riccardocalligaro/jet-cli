import 'dart:io';

import 'package:yaml/yaml.dart';

import 'cli_utils.dart';

loadConfig() {
  File file = File('jet.yaml');
  String yamlString = file.readAsStringSync();
  Map yaml = loadYaml(yamlString);
  return yaml;
}

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
