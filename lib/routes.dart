import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tasks/views/Splashscreen.dart';
import 'package:tasks/views/addtaskScreen.dart';
import 'package:tasks/views/homeScreen.dart';
import 'package:tasks/views/loginScreen.dart';
import 'package:tasks/views/onboardingscreen.dart';
import 'package:tasks/views/registerscreen.dart';

import 'bindings/intial_bindings.dart';

class AppRoutes {
  // Route names (constants)

  static const String splashScreen = '/';

  static const String onboardingScreen = '/onboarding';
  static const String homeScreen = '/home';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String addTaskScreen = '/addTask';

  // GetX Named Routes with Bindings
  static List<GetPage> routes = [

    GetPage(
      name: splashScreen,
      page: () => Splashscreen(),
      binding: InitialBindings(),
    ),

    GetPage(
      name: onboardingScreen,
      page: () => Onboardingscreen(),
      binding: InitialBindings(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      binding: InitialBindings(),
    ),
    GetPage(
      name: registerScreen,
      page: () => Registerscreen(),
      binding: InitialBindings(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      binding: InitialBindings(),
    ),
    GetPage(
      name: addTaskScreen,
      page: () => AddTaskScreen(),
      binding: InitialBindings(),
    ),
  ];
}
