import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:todos_app/feature/todos/domain/model/todo_domain_model.dart';
import 'package:todos_app/feature/todos/domain/repository/todos_repository.dart';

part 'todos_state.dart';
part 'todos_event.dart';


class TodosBloc extends Bloc<TodosEvent, TodosState> {
  
  final TodosRepository todosRepository; 

  TodosBloc({
    required this.todosRepository
  }) : super(TodosInitial()) {
    on<GetTodos>((event, emit) async {
      emit(TodosLoading());

       final todosResult = await todosRepository.getTodos(
         request: event.request
       );

       todosResult.fold(
         (failure) {
           emit(TodosFailure(failure: failure, event: event));
         },
         (todos) {
            emit(TodosLoadSuccess(todos: todos));
         },
       );

    });
  }
}
