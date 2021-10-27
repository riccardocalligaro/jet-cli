import 'package:jet_cli/src/renderer/renderer.dart';
import 'package:jet_cli/src/utils/builder_utils.dart';
import 'package:jet_cli/src/utils/file_utils.dart';
import 'package:jet_cli/src/variables/data/repository/repository_impl_variables.dart';
import 'package:jet_cli/src/variables/domain/repository/repository_variables.dart';
import 'package:jet_cli/src/variables/feature_variables.dart';
import 'package:jet_cli/src/variables/presentation/bloc_variables.dart';

const String blocFileName = 'feature/presentation/bloc/{{name}}_bloc.jet';
const String eventsFilename = 'feature/presentation/bloc/{{name}}_event.jet';
const String statesFilename = 'feature/presentation/bloc/{{name}}_state.jet';

class BlocBuilder {
  static BlocVariables build(
    FeatureVariables featureVariables, {
    RepositoryImplVariables? repositoryImplVariables,
    RepositoryVariables? repositoryVariables,
  }) {
    final variables = BlocVariables();

    final renamedBloc = renamedFile(
      blocFileName,
      featureVariables.pluralName!,
      featureVariables.featureName!,
    );

    final renamedEvents = renamedFile(
      eventsFilename,
      featureVariables.pluralName!,
      featureVariables.featureName!,
    );

    final renamedStates = renamedFile(
      statesFilename,
      featureVariables.pluralName!,
      featureVariables.featureName!,
    );

    variables.blocImports = importFilenames(
      [
        featureVariables.hasDomainLayer!
            ? featureVariables.domainModelFilename
            : featureVariables.remoteModelFilename,
        repositoryVariables?.filename,
      ],
      featureVariables.packageName!,
    );

    final repoMap = repositoryImplVariables!.toMap(featureVariables);
    // save the content to the file
    saveGeneratedContent(
      renamedBloc,
      env
          .getTemplate(blocFileName)
          .render(variables.toMap(featureVariables)..addAll(repoMap)),
    );

    saveGeneratedContent(
      renamedEvents,
      env.getTemplate(eventsFilename).render(
            variables.toMap(featureVariables)..addAll(repoMap),
          ),
    );

    saveGeneratedContent(
      renamedStates,
      env
          .getTemplate(statesFilename)
          .render(variables.toMap(featureVariables)..addAll(repoMap)),
    );

    variables.blocFilename = renamedBloc;
    variables.statesFilename = renamedStates;
    variables.eventsFilename = renamedEvents;

    return variables;
  }
}
