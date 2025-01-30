import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../routes.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<Onboardingscreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/icons/todo.svg',
      'title': 'Organize Your Tasks Effortlessly',
      'description': 'Create, categorize, and manage your daily tasks with ease, ensuring productivity and efficiency.',
    },
    {
      'image': 'assets/icons/completing.svg',
      'title': 'Seamless Task Management',
      'description': 'Update, delete, or mark tasks as completed to stay on top of your workflow with a simple and intuitive interface.',
    },
    {
      'image': 'assets/icons/todo.svg',
      'title': 'Stay Motivated & Productive',
      'description': 'Track your progress, set deadlines, and boost productivity with smart task reminders and insights.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: SvgPicture.asset(
                        onboardingData[index]['image']!,
                        height: screenHeight * 0.4,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                      child: Text(
                        onboardingData[index]['title']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                      child: Text(
                        onboardingData[index]['description']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: screenWidth * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: onboardingData.length,
                  effect: WormEffect(
                    activeDotColor: Color(0xFF1670E7),
                    dotColor: Colors.grey,
                    dotHeight: screenWidth * 0.02,
                    dotWidth: screenWidth * 0.02,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                if (_currentPage == onboardingData.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.loginScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1670E7),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.3,
                          vertical: screenHeight * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.outfit(
                        fontSize: screenWidth * 0.045,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _pageController.jumpToPage(onboardingData.length - 1);
                        },
                        child: Text(
                          'Skip',
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1670E7),
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (_currentPage < onboardingData.length - 1) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          icon: Icon(Icons.arrow_forward),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
