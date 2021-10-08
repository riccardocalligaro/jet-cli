import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/cli_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/data/remote/remote_datasource_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';

const String remoteDatasourceFileName =
    'feature/data/remote/{{ name }}_remote_datasource.jet';

class RemoteDatasourceBuilder {
  static RemoteDatasourceVariables build(FeatureVariables featureVariables) {
    final variables = RemoteDatasourceVariables();

    okContinue('generating ${featureVariables.pluralName}RemoteDatasource...');

    // save the content to the file
    saveGeneratedContent(
      renamedFile(
        remoteDatasourceFileName,
        featureVariables.pluralName!,
      ),
      env.getTemplate(remoteDatasourceFileName).render(),
    );

    return variables;
  }
}
