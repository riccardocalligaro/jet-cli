import 'package:jet_cli/src/json_to_model/index.dart';
import 'package:jet_cli/src/json_to_model/models/json_options.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/data/remote/remote_model_variables.dart';
import 'package:jet_cli/src/variables/domain/model/domain_model_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';

const String domainModelFileName =
    'feature/domain/model/{{name}}_domain_model.jet';

class DomainModelBuilder {
  static DomainModelVariables build(
    FeatureVariables featureVariables,
    RemoteModelVariables? remoteModelVariables,
  ) {
    final variables = DomainModelVariables();
    variables.name = '${featureVariables.singularNameForModel}DomainModel';

    final renamed = renamedFile(
      domainModelFileName,
      featureVariables.singularNameLowercase!,
      featureVariables.featureName!,
    );

    final content = JsonModelGenerator.run(
      JSONOptions(
        name: '${featureVariables.singularNameForModel}DomainModel',
        remoteModel: remoteModelVariables?.name,
        content: remoteModelVariables!.content!,
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
