// Model untuk menyimpan data todo list sementara
class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      // Static data untuk pengetestan
      // Todo(id: '1', todoText: 'Test', isDone: true),
      // Todo(id: '2', todoText: 'Exercise', isDone: true),
      // Todo(id: '3', todoText: 'Fix bug', ),
      // Todo(id: '4', todoText: 'Eat', ),
      // Todo(id: '5', todoText: 'Rest', ),
    ];
  }
}