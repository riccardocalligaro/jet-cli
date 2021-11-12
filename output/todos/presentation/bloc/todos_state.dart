part of 'todos_bloc.dart';

@immutable
abstract class TodosState {}

class TodosInitial extends TodosState {}

class TodosLoading extends TodosState {}


class TodosLoadSuccess extends TodosState {
  final List<TodoDomainModel> todos;

  TodosLoadSuccess({
    required this.todos,
  });
}

class TodosFailure extends TodosState {
  final Failure failure;
  final TodosEvent event;
  
  TodosFailure({
    required this.failure,
    required this.event,
  });
}
