import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_todo_app/model/task_model.dart';

class TaskController extends GetxController {
// taches
  var tasks = <Task>[].obs;

  Future<List<Task>> getAllTask() async {
    return tasks;
  }

// add task
  Future<void> addTask(Task task) async {
    if (task.title.isNotEmpty) {
      final int lastIndex = tasks.last.id;

      if (lastIndex != -1) {
        int next = lastIndex + 1;
        tasks.add(Task(
            id: next,
            title: task.title,
            description: task.description,
            isCompleted: task.isCompleted));
        kDebugMode ? print("ajout de ${task.title}") : null;
        
        Get.back();
      }
    } else {
      Get.snackbar("Erreur d'ajout", "Le titre est vide");
    }
  }

// edit task
  Future<void> editTask(int id, Task newTask) async {
    // verifier si l'ID est a al position exacte
    final index = tasks.indexWhere((item) => item.id == id);

    // if index est correcte
    if (index != -1) {
      // mettrea  jour la nouvelle tache a la position de l'ancien
      tasks[index] = Task(
          id: id,
          title: newTask.title,
          description: newTask.description,
          isCompleted: newTask.isCompleted);
    }
  }

// delete task
  Future<void> deleteTask(int id) async {
    tasks.removeWhere((item) => item.id == id);
  }

// mark task as completed
  Future<void> markCompleted(int id) async {
    final index = tasks.indexWhere((task) => task.id == id);

    if (index != -1) {
      if (tasks[index].isCompleted != false) {
        tasks.indexWhere((task) => task.isCompleted = true);
      } else {
        tasks.indexWhere((task) => task.isCompleted = false);
      }
    }
  }
}
