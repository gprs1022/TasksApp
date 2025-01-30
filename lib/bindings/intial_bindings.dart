import 'package:get/get.dart';
import 'package:tasks/controllers/auth_controller.dart';
import 'package:tasks/controllers/task_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);  // Persistent Auth Controller
    Get.put(TaskController(), permanent: true);  // Persistent Task Controller
  }
}
