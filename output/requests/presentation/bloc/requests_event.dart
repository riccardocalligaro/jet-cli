part of 'request_bloc.dart';

@immutable
abstract class RequestEvent {}

class SendRequest extends RequestEvent {
  final RequestDomainModel request;

  SendRequest({
    required this.request,
  });
}
