part of 'todos_bloc.dart';

@immutable
abstract class TodosEvent {}

class GetTodos extends TodosEvent {
  final RequestDomainModel request;

  GetTodos(
    {required this.request,}
  );
}
