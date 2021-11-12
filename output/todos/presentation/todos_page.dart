import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todos_app/feature/todos/presentation/bloc/todos_bloc.dart';
import 'package:todos_app/feature/todos/presentation/todos_loaded.dart';

class TodosPage extends StatefulWidget {
  TodosPage({Key? key}) : super(key: key);

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {

  @override
  void initState() {
    super.initState();
    
    BlocProvider.of<TodosBloc>(context).add(GetTodos());
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoading) {
          return Text('Loading');
        } else if (state is TodosFailure) {
          return Text('Failure');
        } else if (state is TodosLoadSuccess) {
          return TodosLoaded(
            todos: state.todos,
          );
        }

        return Text('Error: $state');
      },
    );
  }
}
