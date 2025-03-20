import 'package:flutter/material.dart';

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

  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}