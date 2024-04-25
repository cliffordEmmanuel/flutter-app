import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'task.dart';
import 'tasklist.dart';
import 'data.dart';
import 'requesttaskpage.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crowd Tasks',
      home: TasksPage(),
    );
  }
}

class TasksPage extends StatefulWidget {
  TasksPage({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> with WidgetsBindingObserver {
  List<Task>? pendingTasksList;
  List<Task>? acceptedTasksList;
  List<Task>? completedTasksList;
  List<Task>? declinedTasksList;
  List<Task>? myTasksList;
  String? _filePath;

  @override
  void initState() {
    super.initState();

    // this enables app state to be observed throughout its lifecycle.
    WidgetsBinding.instance.addObserver(this);

    pendingTasksList = <Task>[];
    acceptedTasksList = <Task>[];
    completedTasksList = <Task>[];
    declinedTasksList = <Task>[];
    pendingTasksList?.addAll(pendingTasks);
    acceptedTasksList?.addAll(acceptedTasks);
    completedTasksList?.addAll(completedTasks);
    declinedTasksList?.addAll(rejectedTasks);

    // getting the file the underlying application
    // this assumes the file is available on the device..
    getApplicationDocumentsDirectory().then((value) {
      _filePath = value.path;
      String _fileName = '$_filePath/pendingTasks.json';
      File file = File(_fileName);


      file.exists().then((exists) {
        if (exists) {
          file.readAsString().then((value) {
            var taskJson = jsonDecode(value) as List;
            setState(() {
              pendingTasksList =
                  taskJson.map((taskJson) => Task.fromJson(taskJson)).toList();
            });
          }).catchError((onError) {
            print(onError);
          });
        } else {
          // Create the file if it doesn't exist
          file.create().then((file) {
            print('File created: $_fileName');
            file.writeAsString(jsonEncode([]));
          }).catchError((onError) {
            print('Error creating file: $onError');
          });
        }
      }).catchError((onError) {
        print('Error checking file existence: $onError');
      });

      // file.readAsString().then((value){
      //   var taskJson = jsonDecode(value) as List;
      //   setState(() {
      //     pendingTasksList =
      //         taskJson.map((taskJson) => Task.fromJson(taskJson)).toList();
      //   });
      // }).catchError((onError){
      //   print(onError);
      // });
    });
  }

  // monitoring the various states of the applife cycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        print('AppLifecycleState.paused');
        var jsonData = json.encode(pendingTasksList);
        String _fileName = '$_filePath/pendingTasks.json';
        var file = File(_fileName);
        file.writeAsString(jsonData);
        break;
      case AppLifecycleState.resumed:
        print('AppLifecycleState.resumed');
        break;
      case AppLifecycleState.detached:
        print('AppLifecycleState.detached');
        break;
      case AppLifecycleState.inactive:
        print('AppLifecycleState.inactive');
        break;
      default:
        print('$state');
        break;
    }
  }

  void acceptTask(Task task) {
    setState(() {
      pendingTasksList?.remove(task);
      acceptedTasksList?.add(task.copyWith(accepted: true));
    });
  }

  void declineTask(Task task) {
    setState(() {
      pendingTasksList?.remove(task);
      declinedTasksList?.add(task.copyWith(accepted: false));
    });
  }

  void abandonTask(Task task) {
    setState(() {
      acceptedTasksList?.remove(task);
      declinedTasksList?.add(task.copyWith(accepted: false));
    });
  }

  void completeTask(Task task) {
    setState(() {
      acceptedTasksList?.remove(task);
      completedTasksList?.add(task.copyWith(completed: DateTime.now()));
    });
  }

  // this enables us to access the current instance of the TasksPageState from
  // anywhere in code.
  static TasksPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<TasksPageState>();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Crowd Tasks"),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                _buildCategoryTab("Requests"),
                _buildCategoryTab("Accepted"),
                _buildCategoryTab("Completed"),
                _buildCategoryTab("Declined"),
              ],
            )),
        body: TabBarView(
          children: [
            TasksList(title: "Pending Requests", tasks: pendingTasksList),
            TasksList(title: "Accepted", tasks: acceptedTasksList),
            TasksList(title: "Completed", tasks: completedTasksList),
            TasksList(title: "Rejected", tasks: declinedTasksList),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final task = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestTaskPage(
                  clients: theClients,
                ),
              ),
            );
            setState(() {
              pendingTasksList?.add(task.copyWith());
            });
          },
          tooltip: 'Request a Task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String title) {
    return Tab(
      child: Text(title),
    );
  }
}
