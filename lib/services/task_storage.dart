import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskStorage {
  static const String _storageKey = 'tasks';

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) {
      return [];
    }

    final List<dynamic> decodedList = jsonDecode(jsonString);

    return decodedList
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(tasks.map((task) => task.toJson()).toList());

    await prefs.setString(_storageKey, jsonString);
  }
}
