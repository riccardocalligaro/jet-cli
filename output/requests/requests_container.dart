import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final _sl = GetIt.instance;

class RequestContainer {
  static Future<void> init() async {
    _sl.registerLazySingleton(
      () => RequestRemoteDatasource(
        client: _sl(),
      ),
    );

    _sl.registerLazySingleton<RequestRepository>(
      () => RequestRepositoryImpl(
        requestRemoteDatasource: _sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<RequestBloc>(
        create: (context) => RequestBloc(
          requestRepository: _sl(),
        ),
      ),
    ];
  }
}
