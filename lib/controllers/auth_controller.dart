import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks/routes.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Text Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Toggle password visibility
  var isPasswordHidden = true.obs;

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(Duration(milliseconds: 50));
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        // Redirect authenticated users to HOME screen
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        // Redirect unauthenticated users to LOGIN screen
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    });
  }

  /// **🔹 Login Function**
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter email and password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      print("🔥 Attempting to log in with: $email");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ User Logged In: ${userCredential.user?.email}");
      Get.offAllNamed(AppRoutes.homeScreen);

    } on FirebaseAuthException catch (e) {
      print("🔥 Login Error: ${e.code} - ${e.message}");
      Get.snackbar("Login Failed", e.message ?? "Error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  /// **🔹 Signup Function**
  Future<void> register() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Update Firebase User Profile with Username
      await userCredential.user?.updateDisplayName(username);
      await userCredential.user?.reload();


      await _auth.signOut();


      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      usernameController.clear();

      // Navigate to Login Screen
      Get.offAllNamed(AppRoutes.loginScreen);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Registration Error", e.message ?? "Error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }


  Future<void> forgotPassword() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Enter your email to reset password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset link sent!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }


  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.loginScreen);
  }
}
