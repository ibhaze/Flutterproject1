import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflct/pages/home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Handle Next button
  void _goToNextPageOrHome() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionsBuilder: (_, animation, __, child) {
            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(0, 0.15),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                );

            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation);

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        ),
      );
    }
  }

  //  onboarding pages layout
  Widget _buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image, height: 250, fit: BoxFit.contain),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.nunitoSans(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.nunitoSans(
              fontSize: 18,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Pagination dots
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF663366),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content: pages + bottom controls
            Column(
              children: [
                // Gives a bit of space at the top so the bar isn't glued to the edge
                const SizedBox(height: 24),

                // Pages
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildPage(
                        image: 'assets/images/mirror.png',
                        title: 'Welcome to RFLCT',
                        description:
                            'A calm space to slow down, process your day, and reflect.',
                      ),
                      _buildPage(
                        image: 'assets/images/journal.png',
                        title: 'Capture Your Thoughts',
                        description:
                            'Record, track, and organise your reflections in one place.',
                      ),
                      _buildPage(
                        image: 'assets/images/grow.png',
                        title: 'Grow with Intention',
                        description:
                            'Turn your reflections into small daily changes over time.',
                      ),
                    ],
                  ),
                ),

                // Bottom: Skip + Next
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SKIP text button
                      GestureDetector(
                        onTap: () {
                          // Jump to last page
                          _pageController.animateToPage(
                            2, // last page index (0,1,2)
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text(
                          "Skip >",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // NEXT button
                      ElevatedButton(
                        onPressed: _goToNextPageOrHome,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(_currentPage == 2 ? 'Get started' : 'Next'),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Top progress indicator bar
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 3, // because i have 3 pages
                backgroundColor: Colors.white.withOpacity(0.2),
                color: Colors.white,
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
