import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/cli_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/data/remote/remote_model_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';

const String remoteModelFileName =
    'feature/data/remote/{{name}}_remote_model.jet';

class RemoteModelBuilder {
  static RemoteModelVariables build(FeatureVariables featureVariables) {
    final variables = RemoteModelVariables();
    variables.name = '${featureVariables.singularNameForModel}RemoteModel';

    // save the content to the file
    saveGeneratedContent(
      renamedFile(
        remoteModelFileName,
        featureVariables.singularNameLowercase!,
      ),
      env.getTemplate(remoteModelFileName).render({'name': variables.name}),
    );

    return variables;
  }
}
