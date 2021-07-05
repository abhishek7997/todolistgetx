import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/Todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void edit(String id, String desc) {
    var idx = todos.indexWhere((e) => e.id == id);
    var editing = todos[idx];
    editing.description = desc;
    todos[idx] = editing;
    update();
  }

  void updateById(String id) {}

  int getIndexById(String id) {
    return todos.indexWhere((e) => e.id == id);
  }

  Todo getTodoById(String id) {
    return todos.firstWhere((e) => e.id == id);
  }

  List<Todo> getAll() {
    return todos;
  }

  List<Todo> getActive() {
    return (todos.where((e) => (e.done == false)).toList());
  }

  List<Todo> getCompleted() {
    return (todos.where((e) => (e.done == true)).toList());
  }

  void removeById(String id) {
    todos.removeWhere((e) => e.id == id);
    update();
  }

  @override
  void onInit() {
    List storedTodos = GetStorage().read<List>('todos') ?? <Todo>[];

    if (todos.isEmpty)
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;

    ever(todos, (_) {
      print("Saving data...");
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
