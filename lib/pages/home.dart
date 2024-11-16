import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todo_app/controller/task_controller.dart';
import 'package:get_todo_app/model/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController taskController = Get.put(TaskController());

  final TextEditingController taskTitle = TextEditingController();
  final TextEditingController taskDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    final tasks = taskController.tasks.value;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Get Todo App'),
        ),
        body: Scaffold(
          body: Column(
            children: [
              Container(
                height: screenHeight * 0.2,
                color: Colors.blue,
                child: const Text('Applciation Todo'),
              ),
              Container(
                  height: screenHeight * 0.7,
                  child: FutureBuilder(
                      future: taskController.getAllTask(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Erreur de chargemenst des taches");
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text(snapshot.data![index].title),
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addTask();
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  void addTask() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    TextField(
                      controller: taskTitle,
                      decoration: InputDecoration(
                          hintText: 'Entrer le titre d ela tache'),
                    ),

                    // description
                    TextField(
                      controller: taskTitle,
                      decoration: InputDecoration(
                          hintText: 'Entrer le titre de la tache'),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Task task = Task(
                          id: 0,
                          title: taskTitle.text,
                          description: taskDescription.text,
                          isCompleted: false);
                      taskController.addTask(task);
                    },
                    icon: Icon(Icons.add))
              ],
            ));
  }
}
