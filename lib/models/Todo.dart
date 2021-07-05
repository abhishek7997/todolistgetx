import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  String id;
  String description;
  bool done;

  Todo({
    this.id = '',
    this.description = '',
    this.done = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        description: json["description"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "done": done,
      };
}
