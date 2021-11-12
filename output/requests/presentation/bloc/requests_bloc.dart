import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:todos_app/feature/requests/domain/model/request_domain_model.dart';
import 'package:todos_app/feature/requests/domain/repository/requests_repository.dart';

part 'request_state.dart';
part 'request_event.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestsRepository requestsRepository;

  RequestBloc({required this.requestsRepository}) : super(RequestInitial()) {
    on<SendRequest>((event, emit) async {
      emit(RequestLoading());

      final requestResult =
          await requestsRepository.sendRequest(request: event.request);

      requestResult.fold(
        (failure) {
          emit(RequestFailure(failure: failure, event: event));
        },
        (request) {
          emit(RequestLoadSuccess(request: request));
        },
      );
    });
  }
}
