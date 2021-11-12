part of 'request_bloc.dart';

@immutable
abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestLoadSuccess extends RequestState {
  final RequestDomainModel request;

  RequestLoadSuccess({
    required this.request,
  });
}

class RequestFailure extends RequestState {
  final Failure failure;
  final RequestEvent event;

  RequestFailure({
    required this.failure,
    required this.event,
  });
}
