import 'package:flutter/material.dart';
import 'task.dart';
import 'taskcarditem.dart';


class TasksList extends StatelessWidget {
  final String? title;
  final List<Task>? tasks;

  const TasksList({Key? key, this.title, this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          child: Text(title!),
          padding: EdgeInsets.only(top: 16.0),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: tasks?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks![index];
                  return TaskCardItem(task: task);
                }))
      ],
    );
  }
}
