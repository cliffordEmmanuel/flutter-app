import 'task.dart';
import 'client.dart';

final uuid = UUID();
final pendingTasks = [
  Task(
    uuid: uuid.generate(),
    description: "Deliver my groceries",
    dueDate: DateTime.now().add(const Duration(days: 1)),
    client: Client(
      name: "Ronald",
      number: "9876543210",
      photoURL: "https://i.pravatar.cc/300?img=65",
    ),
  ),
  Task(
    uuid: uuid.generate(),
    description: "Walk my dogs",
    dueDate: DateTime.now().add(const Duration(hours: 5)),
    client: Client(
      name: "Sally",
      number: "1234567890",
      photoURL: "https://i.pravatar.cc/300?img=49",
    ),
  ),
  Task(
    uuid: uuid.generate(),
    description: "Start a new project",
    dueDate: DateTime.now(),
    client: Client(
      name: "John",
      number: "11111111111",
      photoURL: "https://i.pravatar.cc/300?img=50",
    ),
  ),
  Task(
    uuid: uuid.generate(),
    description: "Record a new video",
    dueDate: DateTime.now(),
    client: Client(
      name: "John",
      number: "11111111111",
      photoURL: "https://i.pravatar.cc/300?img=50",
    ),
  ),
];
final acceptedTasks = [
  Task(
    uuid: uuid.generate(),
    description: "Write an app",
    dueDate: DateTime.now().add(const Duration(days: 1)),
    accepted: true,
    client: Client(
      name: "Sally",
      number: "1234567890",
      photoURL: "https://i.pravatar.cc/300?img=49",
    ),
  ),
  Task(
    uuid: uuid.generate(),
    description: "Have a chat",
    dueDate: DateTime.now().add(const Duration(hours: 1)),
    accepted: true,
    client: Client(
      name: "John",
      number: "11111111111",
      photoURL: "https://i.pravatar.cc/300?img=50",
    ),
  )
];
final completedTasks = [
  Task(
    uuid: uuid.generate(),
    description: "Buy takeaway",
    dueDate: DateTime.now().add(const Duration(days: 1)),
    completed: DateTime.now(),
    accepted: true,
    client: Client(
      name: "Sally",
      number: "1234567890",
      photoURL: "https://i.pravatar.cc/300?img=49",
    ),
  ),
];
final rejectedTasks = [
  Task(
    uuid: uuid.generate(),
    description: "Take the bins out",
    dueDate: DateTime.now().add(const Duration(days: 1)),
    accepted: false,
    client: Client(
      name: "Harry",
      number: "5678901234",
      photoURL: "https://i.pravatar.cc/300?img=13",
    ),
  ),
];

final theClients = [
  Client(
    name: "Harry",
    number: "5678901234",
    photoURL: "https://i.pravatar.cc/300?img=13",
  ),
  Client(
    name: "Sally",
    number: "1234567890",
    photoURL: "https://i.pravatar.cc/300?img=49",
  ),
  Client(
    name: "John",
    number: "11111111111",
    photoURL: "https://i.pravatar.cc/300?img=50",
  ),
  Client(
    name: "Ronald",
    number: "9876543210",
    photoURL: "https://i.pravatar.cc/300?img=65",
  ),
];
