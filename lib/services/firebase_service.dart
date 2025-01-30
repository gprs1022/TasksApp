import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String tasksCollection = "tasks";


  static Future<List<Map<String, dynamic>>> getUserTasks(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(tasksCollection).where("userId", isEqualTo: userId)
              .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching tasks: $e");
      return [];
    }
  }


  static Future<Map<String, dynamic>?> getTaskById(String taskId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection(tasksCollection).doc(taskId).get();
      return documentSnapshot.exists
          ? documentSnapshot.data() as Map<String, dynamic>
          : null;
    } catch (e) {
      print("Error fetching task by ID: $e");
      return null;
    }
  }


  static Future<void> addTask(Map<String, dynamic> taskData) async {
    try {
      await _firestore.collection(tasksCollection).add(taskData);
    } catch (e) {
      print("Error adding task: $e");
    }
  }


  static Future<void> updateTask(
      String taskId, Map<String, dynamic> updatedData) async {
    try {


      print("Attempting to update task: $taskId with data: $updatedData");
      await _firestore
          .collection(tasksCollection)
          .doc(taskId)
          .update(updatedData);

      print("Task updated successfully!");
    } catch (e) {
      print("Error updating task: $e");
    }
  }


  static Future<void> deleteTask(String taskId) async {
    try {
      print("🗑️ Attempting to delete task: $taskId");

      await _firestore.collection(tasksCollection).doc(taskId).delete();
    } catch (e) {
      print("Error deleting task: $e");
    }
  }


  static Future<List<Map<String, dynamic>>> getSubCollectionData(
      String taskId, String subCollection) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(tasksCollection)
          .doc(taskId)
          .collection(subCollection)
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching subcollection data: $e");
      return [];
    }
  }
}
