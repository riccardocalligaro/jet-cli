import 'package:dartz/dartz.dart';
import 'package:todos_app/feature/todos/domain/model/todo_domain_model.dart';
import 'package:todos_app/feature/todos/data/remote/todo_remote_model.dart';
import 'package:todos_app/feature/todos/data/remote/todos_remote_datasource.dart';
import 'package:todos_app/feature/todos/domain/repository/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {

  final TodosRemoteDatasource todosRemoteDatasource;

  TodosRepositoryImpl({
    required this.todosRemoteDatasource,
  });

  @override
  Future<Either<Failure, List<TodoDomainModel>>> getTodos({required RequestDomainModel request,}) async {
    try {
      final remoteTodos =
          await todosRemoteDatasource.getTodos(request: request);

      final domainTodos = remoteTodos
          .map((r) => TodoDomainModel.fromRemoteModel(r))
          .toList();  

      return Right(domainTodos);
    } catch (e, s) {
      return Left(handleError(e, s));
    }
  }
}

