import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/controllers/auth_controller.dart';
import 'package:tasks/routes.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.08;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.07),

                // App Logo
                CircleAvatar(
                  radius: screenWidth * 0.18,
                  backgroundColor: Colors.blue,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/tasks.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // Email Field
                TextField(
                  controller: authController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "User name or email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),


                Obx(
                      () => TextField(
                    controller: authController.passwordController,
                    obscureText: authController.isPasswordHidden.value,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authController.isPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          authController.isPasswordHidden.toggle();
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),


                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => authController.forgotPassword(),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),


                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () => authController.login(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If you are not registered just ",
                      style: TextStyle(fontSize: screenWidth * 0.035),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.registerScreen),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.05),


                Text(
                  "By providing credentials, you agree to the Tasks app",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: screenWidth * 0.03),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
