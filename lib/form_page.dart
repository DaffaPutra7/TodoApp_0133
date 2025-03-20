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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}