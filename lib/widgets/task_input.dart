import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskInput extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(String title, DateTime date) onAdd;

  const TaskInput({super.key, required this.selectedDate, required this.onAdd});

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final TextEditingController _controller = TextEditingController();

  late DateTime _taskDate;

  @override
  void initState() {
    super.initState();
    _taskDate = dateOnly(widget.selectedDate);
  }

  @override
  void didUpdateWidget(TaskInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      _taskDate = dateOnly(widget.selectedDate);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _taskDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _taskDate = dateOnly(picked);
      });
    }
  }

  void _submit() {
    final title = _controller.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite uma tarefa antes de adicionar.')),
      );

      return;
    }

    widget.onAdd(title, _taskDate);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: 'Tarefa',
                  hintText: 'Nova Tarefa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(formatShortDate(_taskDate)),
                    ),
                  ),

                  const SizedBox(width: 12),

                  FilledButton(
                    onPressed: _submit,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(120, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('ADICIONAR'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
