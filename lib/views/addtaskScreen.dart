import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  final String? taskId;
  final String? title;
  final String? description;

  AddTaskScreen({
    this.taskId,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();


    TextEditingController titleController =
    TextEditingController(text: title ?? "");
    TextEditingController descController =
    TextEditingController(text: description ?? "");

    final bool isEditing = (taskId != null);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Task" : "Add Task"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "Enter task title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Description
            TextField(
              controller: descController,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Enter task description",
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 24),

            // Save/Update Button
            ElevatedButton(
              onPressed: () async {
                final String enteredTitle = titleController.text.trim();
                final String enteredDesc = descController.text.trim();

                if (enteredTitle.isEmpty || enteredDesc.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Fields cannot be empty",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }

                if (isEditing) {
                  await taskController.updateTask(
                      taskId!, enteredTitle, enteredDesc);
                } else {
                  await taskController.addTask(enteredTitle, enteredDesc);
                }


                Get.back();
              },
              child: Text(isEditing ? "Update" : "Save"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            )
          ],
        ),
      ),
    );
  }
}
