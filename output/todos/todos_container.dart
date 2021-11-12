import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';





final _sl = GetIt.instance;

class TodosContainer {
  static Future<void> init() async {
    _sl.registerLazySingleton(
      () => TodosRemoteDatasource(
        client: _sl(),
      ),
    );

    _sl.registerLazySingleton<TodosRepository>(
      () => TodosRepositoryImpl(
        todosRemoteDatasource: _sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<TodosBloc>(
        create: (context) => TodosBloc(
          todosRepository: _sl(),
        ),
      ),
    ];
  }
}

