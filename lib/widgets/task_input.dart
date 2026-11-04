import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskInput extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(String title DateTime date) onAdd;

  const TaskInput({
    super.key,
    required this.selectedDate,
    required this.onAdd,
  });

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput>{
  final TextEditingController _controller = TextEditingController();
  late DateTime _taskDate;

  @override
  void initState(){
    super.initState();
    _taskDate = dateOnly(widge.selectedDate);
  }

  @override
  void didUpdateWidget(TaskInput oldWidget){
  if (!isSameDay(oldWidget.selectedDate,widget.selectedDate)){
  _taskDate = dateOnly(widget.selectedDate);
    }
   } 


  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
      }

      Future<void> _pickDate() async {
        final picked = await ShowDatepicker(
          context: context,
          initialDate: _taskDate,
          firstDate: Datetime(2020),
          lastDate: Datetime(2100),
        );

        if (picked != null){
          setState(() {
            _taskDate = dateOnly(picked);
          });
        }
      }

      void _submit(){
        final title = _controller.text.trim();
        
      }
    }