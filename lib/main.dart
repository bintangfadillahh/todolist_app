import 'package:flutter/material.dart';
import '../model/todo.dart'; // Import model untuk penyimpanan todo item (tidak tersambung ke database hanya data sementara)

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final todoLists = Todo.todoList();
  final _todoController = TextEditingController(); // Set controller untuk textfield

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoLoo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TodoLoo', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF5F52EE),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 15,
                            bottom: 20,
                          ),
                          child: Text(
                            'All Todo',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (Todo todoo in todoLists)
                          TodoItem(
                            todo: todoo,
                            onTodoChange: _handleTodoChange,
                            onDeleteItem: _deleteTodoItem,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Fieldtext untuk menambahkan todo item
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                              hintText: 'Add new Todo',
                              border: InputBorder.none)),
                    ),
                  ),
                  // Button '+' untuk penambahan item todo
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _addTodoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                      ),
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function untuk handle perubahan pada checkbox todo berupa pengecekan field isDone untuk merubah checkbox dan linetrough text
  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  // Function untuk menghapus todo berdasarkan id unik
  void _deleteTodoItem(String id) {
    setState(() {
      todoLists.removeWhere((item) => item.id == id);
    });
  }

  // Function untuk add new todo item
  void _addTodoItem(String toDo) {
    setState(() {
      todoLists.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Id digenerate menggunakan datetime untuk mendapatkan id unik yang akan digunakan untuk function delete
          todoText: toDo));
    });
    _todoController.clear(); // Clear controller setiap melakukan penambahan list todo, agar field text kosong 
  }
}


// Widget untuk Item Todo yang berisi checkbox, judul todo, dan tombol delete
class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChange;
  final onDeleteItem;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onTodoChange,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Color(0xFF5F52EE)),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Color(0xFFCB0F0F),
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
