import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Todo.dart';
import '../controllers/TodoController.dart';
import 'TodoScreen.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({
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
                    Todo? removed = todoController.getCompleted()[idx];
                    var removedIdx = todoController.getIndexById(removed.id);
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
                            todoController.todos.insert(removedIdx, removed!);
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
            itemCount: todoController.getCompleted().length),
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
        todoController.getCompleted()[idx].description.replaceAll("\n", ""),
        style: (todoController.getCompleted()[idx].done)
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
        var selectedId = todoController.getCompleted()[selectedIdx].id;
        Get.to(() => TodoScreen(), arguments: selectedId);
      },
      leading: Checkbox(
        value: todoController
            .getTodoById(todoController.getCompleted()[idx].id)
            .done,
        onChanged: (bool? value) {
          var changed =
              todoController.getTodoById(todoController.getCompleted()[idx].id);
          changed.done = value!;
          todoController.todos[todoController.getIndexById(changed.id)] =
              changed;
        },
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
