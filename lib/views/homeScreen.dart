import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

import 'addtaskScreen.dart'; // Adjust this import if needed

class HomeScreen extends StatelessWidget {

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Tasks",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.blue, size: 28),
            // Calls fetchUserTasks() to load tasks for the current user
            onPressed: () => taskController.fetchUserTasks(),
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.blue, size: 28),
            onPressed: () async {
              try {

                await FirebaseAuth.instance.signOut();


                Get.snackbar(
                  "Logged Out",
                  "You have been logged out",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );


                Get.offAllNamed("/login");
              } catch (e) {
                // Handle any errors
                Get.snackbar(
                  "Logout Failed",
                  "Something went wrong!",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
          ),

        ],
      ),
      body: Obx(() {


        // Otherwise, build the list of tasks
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            TaskModel task = taskController.tasks[index];

            final taskId = task.id ?? "";
            final taskTitle = task.title ?? "[No Title]";
            final taskDesc = task.description ?? "[No Description]";

            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title & Description
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskTitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              taskDesc,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Edit & Delete
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              // Go to AddTaskScreen for editing
                              Get.to(
                                    () => AddTaskScreen(
                                  taskId: taskId,
                                  title: taskTitle,
                                  description: taskDesc,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              print("🗑️ Attempting to delete Task ID: ${task.id}");
                              taskController.deleteTask(taskId);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Get.to(() => AddTaskScreen());
        },
        child: Icon(Icons.add, size: 30, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
