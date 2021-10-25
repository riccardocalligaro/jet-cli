import 'package:jet_cli/src/json_to_model/index.dart';
import 'package:jet_cli/src/json_to_model/models/json_options.dart';
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

    final renamed = renamedFile(
      remoteModelFileName,
      featureVariables.singularNameLowercase!,
      featureVariables.featureName!,
    );
    final input = multilineInput("Insert model JSON");

    final content = JsonModelGenerator.run(
      JSONOptions(
        name: '${featureVariables.singularNameForModel}RemoteModel',
        content: input,
      ),
    );
    // save the content to the file
    saveGeneratedContent(
      renamed,
      content,
    );

    variables.filename = renamed;

    return variables;
  }
}
