import 'package:get/get.dart';
import 'package:get_todo_app/model/task_model.dart';

class TaskController extends GetxController {
// taches
  var tasks = <Task>[].obs;

// add task
  Future<void> addTask(Task task) async {
    if (task.title.isEmpty) {
      tasks.add(task);
    } else {
      Get.snackbar("Erreur d'ajout", "Le titre est vide");
    }
  }

// edit task
  Future<void> editTask(Task task, Task newTask) async {
    task = newTask;
  }

// delete task

// mark task as completed
}
