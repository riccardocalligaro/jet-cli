import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/builder_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/domain/model/domain_model_variables.dart';

import 'package:jet_cli/src/variables/feature_variables.dart';
import 'package:jet_cli/src/variables/presentation/bloc_variables.dart';
import 'package:jet_cli/src/variables/presentation/page_variables.dart';

const String pageFilename = 'feature/presentation/{{name}}_page.jet';

const String pageLoadedFilename = 'feature/presentation/{{name}}_loaded.jet';

class PageBuilder {
  static PageVariables build(
    FeatureVariables featureVariables, {
    BlocVariables? blocVariables,
    DomainModelVariables? domainModelVariables,
  }) {
    final variables = PageVariables();

    final renamedPage = renamedFile(
      pageFilename,
      featureVariables.modelNameLowercase!,
      featureVariables.featureName!,
    );

    final renamedLoaded = renamedFile(
      pageLoadedFilename,
      featureVariables.modelNameLowercase!,
      featureVariables.featureName!,
    );

    variables.imports = importFilenames(
      [
        blocVariables?.blocFilename,
        renamedLoaded,
      ],
      featureVariables.packageName!,
    );

    variables.loadedImports = importFilenames(
      [
        domainModelVariables?.filename,
      ],
      featureVariables.packageName!,
    );

    saveGeneratedContent(
      renamedLoaded,
      env
          .getTemplate(pageLoadedFilename)
          .render(variables.toMap(featureVariables)),
    );

    // save the content to the file
    saveGeneratedContent(
      renamedPage,
      env.getTemplate(pageFilename).render(variables.toMap(featureVariables)),
    );

    variables.pageFilename = renamedPage;
    variables.pageLoadedFilename = renamedLoaded;

    return variables;
  }
}
