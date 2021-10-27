import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/builder_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/data/remote/remote_datasource_variables.dart';
import 'package:jet_cli/src/variables/data/repository/repository_impl_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';
import 'package:recase/recase.dart';

const String repositoryImplFileName =
    'feature/data/repository/{{name}}_repository_impl.jet';

class RepositoryImplBuilder {
  static RepositoryImplVariables build(
    FeatureVariables featureVariables, {
    RemoteDatasourceVariables? remoteDatasourceVariables,
  }) {
    final variables = RepositoryImplVariables();
    variables.repositoryName = '${featureVariables.pluralName}RepositoryImpl';
    variables.abstractRepositoryName =
        '${featureVariables.pluralName}Repository';

    variables.imports = importFilenames(
      [
        featureVariables.hasDomainLayer!
            ? featureVariables.domainModelFilename
            : '',
        featureVariables.remoteModelFilename,
        featureVariables.remoteDatasourceFilename,
        featureVariables.hasDomainLayer!
            ? featureVariables.repositoryFilename
            : '',
      ],
      featureVariables.packageName!,
    );

    final renamed = renamedFile(
      repositoryImplFileName,
      featureVariables.pluralName!,
      featureVariables.featureName!,
    );

    // save the content to the file
    saveGeneratedContent(
      renamed,
      env
          .getTemplate(repositoryImplFileName)
          .render(variables.toMap(featureVariables)),
    );

    variables.filename = renamed;
    variables.repositoryNameLowercase = featureVariables.hasDomainLayer!
        ? variables.abstractRepositoryName!.camelCase
        : variables.repositoryName;
    variables.usedRepository = featureVariables.hasDomainLayer!
        ? variables.abstractRepositoryName
        : variables.repositoryName;
    return variables;
  }
}
