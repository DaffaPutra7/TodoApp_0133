import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _formController = TextEditingController();
  DateTime? _selectedDateTime;
  final List<Map<String, dynamic>> _tasks = [];

 void _addTask() {
    if (_key.currentState!.validate() && _selectedDateTime != null) {
      setState(() {
        _tasks.add({
          'name': _formController.text,
          'dateTime': _selectedDateTime!,
          'isDone': false, // Default: Not Done
        });
        _formController.clear();
        _selectedDateTime = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Task added successfully"),
          backgroundColor: Colors.teal,
        ),
      );
    }
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedDateTime != null
            ? TimeOfDay.fromDateTime(_selectedDateTime!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "Select a date & time";
    }
    return DateFormat("dd-MM-yyyy HH:mm").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Form Page",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Task Date:", style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatDateTime(_selectedDateTime),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.blue),
                    onPressed: _pickDateTime,
                  ),
                ],
              ),
              Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "First Name",
                      style: TextStyle(color: Colors.purple, fontSize: 14),
                    ),
                    TextFormField(
                      controller: _formController,
                      decoration: InputDecoration(
                        hintText: "Enter your first name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _addTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
                        ),
                        child: const Text("Submit", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "List Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(
                          _tasks[index]['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                       
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}