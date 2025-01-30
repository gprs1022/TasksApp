import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasks/services/firebase_service.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  static TaskController instance = Get.find();

  // Observable list of tasks for the logged-in user
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserTasks(); // Load the logged-in user's tasks
  }

  /// 🔹 Fetch only the logged-in user's tasks (matches updated Firestore rules)
  Future<void> fetchUserTasks() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("User not logged in. Cannot fetch tasks.");
        return;
      }

      final userId = currentUser.uid;

      // Fetch tasks where userId == current user's uid
      final dataList = await FirebaseServices.getUserTasks(userId);
      if (dataList.isEmpty) {
        print("No tasks found for this user.");
      } else {
        print("Tasks fetched: ${dataList.length}");
        for (var data in dataList) {
          print("Task: $data");  // This prints each task data
        }
      }
      // Convert Firestore data to TaskModel list
      List<TaskModel> loadedTasks = [];
      for (var data in dataList) {
        loadedTasks.add(TaskModel.fromMap(data));
      }

      // Update observable list
      tasks.value = loadedTasks;
    } catch (e) {
      print("Error fetching user tasks: $e");
    }
  }


  Future<void> addTask(String title, String description) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("No logged-in user. Cannot create task.");
        return;
      }

      final userId = currentUser.uid;

      final newTaskData = {
        "userId": userId,
        "title": title,
        "description": description,
      };

      await FirebaseServices.addTask(newTaskData);
      print("✅ Task added successfully! Fetching updated tasks...");

      await fetchUserTasks();
    } catch (e) {
      print("Error adding task in controller: $e");
    }
  }


  Future<void> updateTask(String taskId, String title, String description) async {
    if (taskId.isEmpty) {
      print("❌ Cannot update task: Task ID is empty!");
      return;
    }
    try {

      print("🔄 Updating task: $taskId");

      final updatedData = {
        "title": title,
        "description": description,
      };

      await FirebaseServices.updateTask(taskId, updatedData);
      print("✅ Task updated successfully!");
      // Re-fetch tasks after update
      await fetchUserTasks();
    } catch (e) {
      print("Error updating task: $e");
    }
  }


  Future<void> deleteTask(String taskId) async {
    if (taskId.isEmpty) {
      print("❌ Cannot delete task: Task ID is empty!");
      return;
    }
    try {
      print("🗑️ Deleting task: $taskId");
      await FirebaseServices.deleteTask(taskId);

      // Re-fetch tasks after deletion
      await fetchUserTasks();
    } catch (e) {
      print("Error deleting task: $e");
    }
  }
}
