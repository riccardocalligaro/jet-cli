# jet-cli

<p align="center">
  <img src="https://i.imgur.com/YEq82GN.png">
</p>


Throughout the life span of a project, when we build new features, we often need to add new resources to our application. These resources typically require multiple, repetitive operations that we have to repeat each time we define a new resource.

## Commands

### `$ jet feature <name>`

Create a new feature in seconds.

```
jet feature todo

❓ Is plural [Todos] correct?:  [y][n]:
✅ Ok, singular todo, plural: todos
❓ Has domain layer?  [y][n]:
❓ Is response a single object? [y][n]:

🌐 Is action [GET]? [y][n]:

🌐 Generate remote model? [y][n]:
❓ Insert model JSON: {
        "userId": 1,
        "id": 1,
        "title": "delectus aut autem",
        "completed": false
}

🙌 Generated output/todos/data/remote/todo_remote_model.dart

🌐 Generate remote datasource? [y][n]:
✅ Ok, generating TodosRemoteDatasource...
        ❓ Generate response conversion? [y][n]:
        ❓ API path: [/todos]

🙌 Generated output/todos/data/remote/todos_remote_datasource.dart

📁 Generate repository?  [y][n]:
🙌 Generated output/todos/domain/model/todo_domain_model.dart
🙌 Generated output/todos/domain/repository/todos_repository.dart
🙌 Generated output/todos/data/repository/todos_repository_impl.dart

🌊 Generate BloC?  [y][n]:
🙌 Generated output/todos/presentation/bloc/todos_bloc.dart
🙌 Generated output/todos/presentation/bloc/todos_event.dart
🙌 Generated output/todos/presentation/bloc/todos_state.dart

🌇 Generate page presentation? [y][n]:
🙌 Generated output/todos/presentation/todos_loaded.dart
🙌 Generated output/todos/presentation/todos_page.dart

📦 Generate container? [y][n]:
🙌 Generated output/todos/todos_container.dart
```

### `$ jet project <name>`

Create a project in seconds.

```
TODO
```