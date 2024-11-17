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
    var screenWidth = MediaQuery.of(context).size.width;

    final tasks = taskController.tasks.value;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Get Todo App'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Scaffold(
          body: Column(
            children: [
              Container(
                  height: screenHeight * 0.2,
                  width: screenWidth,
                  color: Theme.of(context).primaryColor,
                  child: const Center(
                    child: Text('TaskyApp', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),),
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.7,
                  child: FutureBuilder(
                      future: taskController.getAllTask(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Erreur de chargemenst des taches");
                        }
                        if (snapshot.hasData) {
                          return Obx(() => 
                          ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) {
                                  final item = snapshot.data![index];

                                  return ListTile(
                                    leading: Icon(Icons.task),
                                    title: Text(item.title),
                                    subtitle: Text(item.description),
                                    trailing: IconButton(
                                      onPressed: (){}, 
                                      icon:Icon(
                                        item.isCompleted ? Icons.check_box : Icons.check_box_outline_blank
                                      ) 
                                    ),

                                  );
                                },
                              ));
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
                      controller: taskDescription,
                      decoration: const InputDecoration(
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
                    icon: const Icon(Icons.add))
              ],
            ));
  }
}
