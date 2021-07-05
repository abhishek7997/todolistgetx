import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/Todo.dart';
import '../controllers/TodoController.dart';

var _uuid = Uuid();

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();
  final String todoId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(
        text: (todoId == '')
            ? ''
            : todoController.getTodoById(todoId).description);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text('Create a new task'),
        ),
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Type in',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: TextStyle(fontFamily: 'Merriweather'),
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Merriweather',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 999,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                    onPressed: () {
                      if (todoId != '')
                        todoController.edit(todoId, textEditingController.text);
                      else
                        todoController.todos.add(Todo(
                            description: textEditingController.text,
                            id: _uuid.v4()));
                      Get.back();
                    },
                    child: (todoId == '') ? Text('Add') : Text('Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
