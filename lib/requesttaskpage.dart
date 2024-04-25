import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'client.dart';
import 'task.dart';
import 'data.dart';

class RequestTaskPage extends StatefulWidget {
  final List<Client>? clients;
  RequestTaskPage({Key? key, this.clients}) : super(key: key);

  @override
  RequestTaskPageState createState() {
    return new RequestTaskPageState();
  }
}

class RequestTaskPageState extends State<RequestTaskPage> {
  final _formKey = GlobalKey<FormState>();
  Client? _selectedClient = null;
  String? _description = null;
  DateTime? _dueDate = null;

  static RequestTaskPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<RequestTaskPageState>();
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requesting a task"),
        leading: CloseButton(),
        actions: <Widget>[
          Builder(
            builder: (context) => TextButton(
              child: Text("SAVE"),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                RequestTaskPageState.of(context)?.save();
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<Client>(
                value: _selectedClient,
                onChanged: (client) {
                  setState(() {
                    _selectedClient = client;
                  });
                },
                items: widget.clients
                    ?.map(
                      (f) => DropdownMenuItem<Client>(
                        value: f,
                        child: Text(f.name),
                      ),
                    )
                    .toList(),
                validator: (client) {
                  if (client == null) {
                    return "You must select a client to request the task";
                  }
                  return null;
                },
              ),
              Container(
                height: 16.0,
              ),
              Text("Task description:"),
              TextFormField(
                maxLines: 5,
                inputFormatters: [LengthLimitingTextInputFormatter(200)],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "You must describe the task";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              Container(
                height: 16.0,
              ),
              Text("Due Date:"),
              InputDatePickerFormField(
                firstDate: DateTime(2019),
                lastDate: DateTime(2029, 12, 12),
                initialDate: DateTime.now(),
                onDateSaved: (value) {
                  setState(() {
                    _dueDate = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      Navigator.pop(
        context,
        Task(
          uuid: uuid.generate(),
          description: _description!,
          dueDate: _dueDate!,
          accepted: null,
          completed: null,
          client: _selectedClient!,
        ),
      );
    }
  }
}
