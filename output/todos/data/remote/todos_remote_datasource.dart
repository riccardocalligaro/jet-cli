import 'package:dio/dio.dart';

import 'todo_remote_model.dart';

/// [TodosRemoteDataSource]: Class that handles the remote calls for the todos feature
/// - `baseUrl/todos` Gets the todos
class TodosRemoteDatasource {
  
  final Dio client;

  TodosRemoteDatasource({
    required this.client,
  });

  Future<List<TodoRemoteModel>> getTodos({required RequestDomainModel request,}) async {
  
    final response = await client.get('/todos');

    List<TodoRemoteModel> todos = List<TodoRemoteModel>.from(
      response.data.map(
        (i) => TodoRemoteModel.fromJson(i),
      ),
    );

    return todos;
    
  }
}

