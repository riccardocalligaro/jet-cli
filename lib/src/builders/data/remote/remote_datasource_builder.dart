import 'package:jet_cli/jet_cli.dart';
import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/builder_utils.dart';
import 'package:jet_cli/src/utils/cli_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/data/remote/remote_datasource_variables.dart';
import 'package:jet_cli/src/variables/data/remote/remote_model_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';

const String remoteDatasourceFileName =
    'feature/data/remote/{{name}}_remote_datasource.jet';

class RemoteDatasourceBuilder {
  static RemoteDatasourceVariables build(
    FeatureVariables featureVariables, {
    RemoteModelVariables? remoteModelVariables,
  }) {
    final variables = RemoteDatasourceVariables();

    okContinue('generating ${featureVariables.pluralName}RemoteDatasource...');

    cli.currentLevel++;
    if (boolQuestion('Generate response conversion?')) {
      variables.generate = true;

      variables.path = stringQuestion('API path',
          defaultChoice:
              '/${featureVariables.responseSingleObject! ? featureVariables.singularNameLowercase : featureVariables.pluralNameLowercase}');
    }

    if (remoteModelVariables != null) {
      variables.remoteModel = remoteModelVariables.name;
      variables.imports =
          importSameDirectory(remoteModelVariables.filename!.split('/').last);
    } else {
      variables.remoteModel = stringQuestion('Remote model name',
          defaultChoice: variables.remoteModel);
    }
    cli.currentLevel--;

    final renamedFileForContent = renamedFile(
      remoteDatasourceFileName,
      featureVariables.pluralName!,
      featureVariables.featureName!,
    );

    // save the content to the file
    saveGeneratedContent(
      renamedFileForContent,
      env
          .getTemplate(remoteDatasourceFileName)
          .render(variables.toMap(featureVariables)),
    );

    variables.filename =
        renamedFileWithPackage(renamedFileWithPackage(renamedFileForContent));

    return variables;
  }
}
