import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:intl/intl.dart';

final GlobalKey<_TaskListScreenState> taskListKey = GlobalKey<_TaskListScreenState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Parse().initialize(
    'AppID',
    'https://parseapi.back4app.com/',
    clientKey: 'ClientKey',
    autoSendSessionId: true,
    debug: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
       theme: ThemeData(
        primaryColor: Color(0x2196F3), // Set the primary color of the AppBar

      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: const Key('homeScreen'), 
        appBar: AppBar(
          title: Text('Task App'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Open Tasks'),
              Tab(text: 'Completed Tasks'),
              Tab(text: 'All Tasks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskListScreen(key: const Key('openTasksList'), status: false),
            TaskListScreen(key: const Key('completedTasksList'), status: true),
            TaskListScreen(key: const Key('allTasksList'), status: null),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key('addTaskButton'),
          onPressed: () {
            _showTaskForm(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showTaskForm(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskForm();
      },
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key, required this.status}) : super(key: key);

  final bool? status;

  TaskListScreen._internal({required this.status});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> taskList;

  @override
  void initState() {
    super.initState();
    taskList = _fetchTasks();
  }

  void reloadTasks() {
    print("reloading tasks page");
    setState(() {
      taskList = _fetchTasks();
    });
  }

  Future<List<Task>> _fetchTasks() async {
    final QueryBuilder<Task> queryBuilder = QueryBuilder<Task>(Task())
      // ..whereEqualTo('Status', widget.status == true ? true : false)
      ..orderByAscending('Due_Date');
  if (widget.status != null) {
    // If widget.status is not null, filter by status
    queryBuilder.whereEqualTo('Status', widget.status);
  }
    try {
      ParseResponse result = await queryBuilder.query();
      if (result.success && result.results != null) {
        List<Task> tasks = result.results?.cast<Task>() ?? [];
        return tasks;
      } else {
        print('Error querying tasks: ${result.error?.message}');
        return [];
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  Future<void> _updateTaskStatus(Task task, bool newStatus) async {
    task.status = newStatus;
    try {
      await task.save();
    } catch (e) {
      print('Error updating task status: $e');
    }
  }

  Future<void> _deleteTask(Task task) async {
    try {
      await task.delete();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: taskList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final tasks = snapshot.data ?? [];
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskListItem(
                task: tasks[index],
                onMarkComplete: () {
                  _updateTaskStatus(tasks[index], true);
                  reloadTasks();
                },
                onDelete: () {
                  _deleteTask(tasks[index]);
                  reloadTasks();
                },
              );
            },
          );
        }
      },
    );
  }
}

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onMarkComplete;
  final VoidCallback onDelete;

  const TaskListItem({
    required this.task,
    required this.onMarkComplete,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = task.status ? Color(0xFF2196F3) : Colors.white;

    return Container(
      color: backgroundColor,
      child: ListTile(
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            SizedBox(height: 8),
            Text('Due Time: ${DateFormat('HH:mm').format(task.dueDate)}'),
            SizedBox(height: 4),
            Text('Due Date: ${DateFormat('dd-MM-yyyy').format(task.dueDate)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!task.status)
              ElevatedButton(
                onPressed: onMarkComplete,
                child: Text('Completed'),
              ),
            if (task.status)
              Icon(Icons.check, color: Color.fromARGB(255, 251, 243, 8)),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late String timeZone;

  @override
  void initState() {
    super.initState();
    timeZone = getTimeZoneAbbreviation(); // Initialize timeZone in initState
  }

  String getTimeZoneAbbreviation() {
    return DateTime.now().timeZoneName ?? 'UnknownTimeZone';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Task Description'),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: 'Due Date: ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                  ),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Icon(Icons.calendar_today),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: 'Due Time: ${selectedTime.hour}:${selectedTime.minute} ${timeZone}',
                  ),
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (picked != null && picked != selectedTime) {
                      setState(() {
                        selectedTime = picked;
                      });
                    }
                  },
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (picked != null && picked != selectedTime) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
                child: Icon(Icons.access_time),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
            ElevatedButton(
              onPressed: () {
                _addTask(context,() {
                    // Callback function to trigger the reload of the open task page
                    final openTasksList = context.findAncestorStateOfType<_TaskListScreenState>();
                    openTasksList?.reloadTasks();
                  },
                );
              },
              child: Text('Add Task'),
            ),
      ],
    );
  }

  void _addTask(BuildContext context, VoidCallback onTaskAdded) async {
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      DateTime combinedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      // Create a ParseObject for the 'Task' class
      var taskObject = ParseObject('task')
        ..set<String>('Title', title)
        ..set<String>('Description', description)
        ..set<DateTime>('Due_Date', combinedDateTime)
        ..set<bool>('Status', false);

      try {
        // Save the task object to the database
        await taskObject.save();
        onTaskAdded(); // Trigger the callback
        Navigator.of(context).pop(); // Close the dialog
      } catch (e) {
        print('Error adding task: $e');
      }
    }
  }
}

enum TaskStatus { open, completed, all }

class Task extends ParseObject implements ParseCloneable {
  Task() : super(_keyTableName);
  Task.clone() : this();

  @override
  Task clone(Map<String, dynamic> map) => Task.clone()..fromJson(map);

  static const String _keyTableName = 'task';

  // Define your task properties here
  String get title => get<String>('Title') ?? '';
  set title(String value) => set<String>('Title', value); 

  String get description => get<String>('Description') ?? '';
  set description(String value) =>
      set<String>('Description', value); 

  DateTime get dueDate =>
      get<DateTime>('Due_Date') ?? DateTime.now(); 
  set dueDate(DateTime value) => set<DateTime>('Due_Date', value); 

  bool get status =>
      get<bool>('Status') ?? false; 
  set status(bool value) => set<bool>('Status', value); 


}
