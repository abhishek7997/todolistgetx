import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Todo.dart';
import '../controllers/TodoController.dart';
import 'TodoScreen.dart';

class AllTodos extends StatelessWidget {
  const AllTodos({
    Key? key,
    required this.todoController,
  }) : super(key: key);

  final TodoController todoController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => ListView.separated(
            itemBuilder: (ctx, idx) => Dismissible(
                  key: UniqueKey(),
                  onDismissed: (_) {
                    Todo? removed = todoController.todos[idx];
                    todoController.removeById(removed.id);
                    Get.showSnackbar(
                      GetBar(
                        title: "Task removed",
                        message:
                            'The task "${removed.description}" was successfully removed.',
                        isDismissible: true,
                        duration: Duration(seconds: 5),
                        animationDuration: Duration(seconds: 1),
                        mainButton: TextButton(
                          onPressed: () {
                            if (removed == null) return;
                            todoController.todos.insert(idx, removed!);
                            removed = null;
                          },
                          child: Text('Undo'),
                        ),
                      ),
                    );
                  },
                  child: TodoItem(todoController: todoController, idx: idx),
                ),
            separatorBuilder: (_, __) => Divider(),
            itemCount: todoController.todos.length),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.todoController,
    required this.idx,
  }) : super(key: key);

  final TodoController todoController;
  final idx;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todoController.todos[idx].description.replaceAll("\n", ""),
        style: (todoController.todos[idx].done)
            ? TextStyle(
                color: Colors.red, decoration: TextDecoration.lineThrough)
            : TextStyle(
                fontFamily: 'Raleway',
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        var selectedIdx = idx;
        var selectedId = todoController.getActive()[selectedIdx].id;
        Get.to(() => TodoScreen(), arguments: selectedId);
      },
      leading: Checkbox(
        value: todoController.todos[idx].done,
        onChanged: (bool? value) {
          var changed = todoController.todos[idx];
          changed.done = value!;
          todoController.todos[idx] = changed;
        },
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
