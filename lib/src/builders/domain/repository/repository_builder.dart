import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/builder_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/domain/repository/repository_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';

const String repositoryFileName =
    'feature/domain/repository/{{name}}_repository.jet';

class RepositoryBuilder {
  static RepositoryVariables build(
    FeatureVariables featureVariables,
  ) {
    final variables = RepositoryVariables();

    final renamed = renamedFile(
      repositoryFileName,
      featureVariables.pluralName!,
      featureVariables.featureName!,
    );

    variables.abstractRepositoryName =
        '${featureVariables.pluralName}Repository';

    variables.imports = importFilenames(
      [
        featureVariables.hasDomainLayer!
            ? featureVariables.domainModelFilename
            : featureVariables.remoteModelFilename,
      ],
      featureVariables.packageName!,
    );
    // save the content to the file
    saveGeneratedContent(
      renamed,
      env
          .getTemplate(repositoryFileName)
          .render(variables.toMap(featureVariables)),
    );

    variables.filename = renamed;

    return variables;
  }
}
