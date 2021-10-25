import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/data/remote/remote_datasource_variables.dart';
import 'package:jet_cli/src/variables/data/repository/repository_impl_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';

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

    final renamed = renamedFile(
      repositoryImplFileName,
      featureVariables.singularNameLowercase!,
      featureVariables.featureName!,
    );

    print(variables.toMap(featureVariables));

    // save the content to the file
    saveGeneratedContent(
      renamed,
      env
          .getTemplate(repositoryImplFileName)
          .render(variables.toMap(featureVariables)),
    );

    variables.filename = renamed;

    return variables;
  }
}
