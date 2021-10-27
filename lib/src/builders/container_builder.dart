import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/builder_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/container_variables.dart';
import 'package:jet_cli/src/variables/data/remote/remote_datasource_variables.dart';
import 'package:jet_cli/src/variables/data/repository/repository_impl_variables.dart';
import 'package:jet_cli/src/variables/domain/repository/repository_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';
import 'package:jet_cli/src/variables/presentation/bloc_variables.dart';

const String containerFileName = 'feature/{{name}}_container.jet';

class ContainerBuilder {
  static ContainerVariables build(
    FeatureVariables featureVariables, {
    RemoteDatasourceVariables? remoteDatasourceVariables,
    RepositoryImplVariables? repositoryImplVariables,
    RepositoryVariables? repositoryVariables,
    BlocVariables? blocVariables,
  }) {
    final variables = ContainerVariables();
    variables.imports = importFilenames(
      [
        blocVariables?.blocFilename,
        repositoryVariables?.filename,
        repositoryImplVariables?.filename,
      ],
      featureVariables.packageName!,
    );

    final renamed = renamedFile(
      containerFileName,
      featureVariables.pluralName!,
      featureVariables.featureName!,
    );

    // save the content to the file
    saveGeneratedContent(
      renamed,
      env
          .getTemplate(containerFileName)
          .render(variables.toMap(featureVariables)),
    );

    variables.filename = renamed;

    return variables;
  }
}
