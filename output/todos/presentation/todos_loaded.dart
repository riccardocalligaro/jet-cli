import 'package:flutter/material.dart';

import 'package:todos_app/feature/todos/domain/model/todo_domain_model.dart';

class TodosLoaded extends StatelessWidget {

  final List<TodoDomainModel> todos;

  const TodosLoaded({
    Key? key, 
    required this.todos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todos[index];
        return Text(todo.toString());
      },
    );
  }
}
