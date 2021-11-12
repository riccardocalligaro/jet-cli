import 'package:dartz/dartz.dart';

import 'package:todos_app/feature/todos/domain/model/todo_domain_model.dart';

mixin TodosRepository {
  Future<Either<Failure, List<TodoDomainModel>>> getTodos({required RequestDomainModel request,});
}

