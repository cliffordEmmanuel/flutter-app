import 'package:flutter/material.dart';
import 'task.dart';
import 'main.dart';

class TaskCardItem extends StatelessWidget {
  final Task? task;

  const TaskCardItem({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(task?.uuid),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Padding(
        child: Column(
          children: <Widget>[
            _itemHeader(task!),
            Text(task?.description ?? ''),
            _itemFooter(context, task!)
          ],
        ),
        padding: EdgeInsets.all(8.0),
      ),
    );
  }

  Widget _itemFooter(BuildContext context, Task task) {
    if (task.isCompleted) {
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        alignment: Alignment.centerRight,
        child: Chip(
          label: Text("Completed at: ${task.completed}"),
        ),
      );
    }
    if (task.isRequested) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            onPressed: () {TasksPageState.of(context)?.declineTask(task);},
            child: Text("Decline"),
          ),
          TextButton(
            onPressed: () {TasksPageState.of(context)?.acceptTask(task);},
            child: Text("Accept"),
          ),
        ],
      );
    }
    if (task.isDoing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            onPressed: () {TasksPageState.of(context)?.abandonTask(task);},
            child: Text("Abandon"),
          ),
          TextButton(
            onPressed: () {TasksPageState.of(context)?.completeTask(task);},
            child: Text("Complete"),
          ),
        ],
      );
    }

    return Container();
  }

  Widget _itemHeader(Task task) {
    return Row(children: <Widget>[
      CircleAvatar(
        backgroundImage: NetworkImage(task.client.photoURL),
      ),
      Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("${task.client.name} requested: ")),
      )
    ]);
  }
}
