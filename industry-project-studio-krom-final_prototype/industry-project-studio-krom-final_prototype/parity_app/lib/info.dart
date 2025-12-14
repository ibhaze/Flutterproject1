// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'homepage.dart'; // Import your homepage

class InfoPage extends StatefulWidget {
  final String name;
  final String age;

  const InfoPage({super.key, required this.name, required this.age});

  @override
  // ignore: library_private_types_in_public_api
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final PageController _pageController = PageController();
  int selectedIndex = -1; // To track the selected image
  bool isLoading = false; // To track the loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE8D5),
      body: isLoading
          ? _buildLoadingScreen() // Show loading screen if isLoading is true
          : Column(
              children: [
                const SizedBox(height: 50),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotColor: const Color(0xFFF9D87C),
                      activeDotColor: const Color(0xFFF3B340),
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      _buildPage(
                        title: "Get Daily Questions",
                        description:
                            "View different opinions on selected topics & get to reflect on various viewpoints.",
                        imagePath: 'assets/images/Mind.png',
                      ),
                      _buildPage(
                        title: "Encourage Consistency with Reminders",
                        description:
                            "Schedule question reminders to suit your routine.",
                        imagePath: 'assets/images/alarm.png',
                      ),
                      _buildLastPage(
                        title: "Choose Your Character",
                        description:
                            "Select a character that suits your personality.",
                        gridImages: [
                          'assets/images/girl3.png',
                          'assets/images/girl4.png',
                          'assets/images/girl5.png',
                          'assets/images/man3.png',
                          'assets/images/boy.png',
                          'assets/images/man2.png',
                          'assets/images/girl1.png',
                          'assets/images/man1.png',
                          'assets/images/girl2.png',
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF3B340),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shadowColor: Colors.black.withOpacity(0.5),
                          elevation: 5,
                        ),
                        onPressed: () {
                          if (_pageController.page == 2) {
                            if (selectedIndex != -1) {
                              // Proceed only if an image is selected
                              setState(() {
                                isLoading = true;
                              });
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.pushReplacement(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      name: widget.name,
                                      age: widget.age,
                                      avatar: _getSelectedImage(),
                                      questionHistory: [],
                                      todayQuestion:
                                          '', // Pass the selected avatar
                                    ),
                                  ),
                                );
                              });
                            } else {
                              // Show a snack bar if no image is selected
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select a character!"),
                                ),
                              );
                            }
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          'Next >',
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xFF313B40),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFFF3B340),
            strokeWidth: 4,
          ),
          const SizedBox(height: 30),
          if (selectedIndex != -1)
            Image.asset(
              _getSelectedImage(),
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          const SizedBox(height: 10),
          Text(
            "Customizing your character...",
            style: GoogleFonts.gloock(
              fontSize: 20,
              color: const Color(0xFF313B40),
            ),
          ),
        ],
      ),
    );
  }

  String _getSelectedImage() {
    // Return the selected image path
    List<String> gridImages = [
      'assets/images/girl3.png',
      'assets/images/girl4.png',
      'assets/images/girl5.png',
      'assets/images/man3.png',
      'assets/images/boy.png',
      'assets/images/man2.png',
      'assets/images/girl1.png',
      'assets/images/man1.png',
      'assets/images/girl2.png',
    ];
    return gridImages[selectedIndex];
  }

  Widget _buildPage({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              height: 220,
              width: 220,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Text(
                title,
                style: GoogleFonts.gloock(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF313B40),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Text(
                description,
                style: GoogleFonts.nunitoSans(
                  fontSize: 18,
                  color: const Color(0xFF313B40),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastPage({
    required String title,
    required String description,
    required List<String> gridImages,
  }) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.gloock(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF313B40),
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 18,
                    color: const Color(0xFF313B40),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: gridImages.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(
                              color: const Color(0xFFF3B340),
                              width: 10,
                              strokeAlign: BorderSide.strokeAlignCenter)
                          : null,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        gridImages[index],
                        fit: BoxFit.cover,
                        width: 60, // Reduced size
                        height: 60,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
