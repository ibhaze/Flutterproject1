import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  late List<AnimationController> parityControllers;
  late List<Animation<double>> parityAnimations;

  bool showParityList = false;

  @override
  void initState() {
    super.initState();

    // Initial fade-in and fade-out animation
    fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeInOut),
    );

    fadeController.forward().then((value) async {
      await Future.delayed(
          const Duration(seconds: 1)); // Pause before fading out
      fadeController.reverse().then((value) {
        setState(() => showParityList = true);
        _startParityAnimations();
      });
    });

    // Fade-in for each parity text
    parityControllers = List.generate(
        5,
        (index) => AnimationController(
              duration: const Duration(milliseconds: 500),
              vsync: this,
            ));

    parityAnimations = parityControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn),
      );
    }).toList();
  }

  void _startParityAnimations() async {
    for (var i = 0; i < parityControllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      parityControllers[i].forward();
    }

    // Wait for the last animation to finish, then fade out
    await Future.delayed(const Duration(seconds: 1));
    for (var controller in parityControllers.reversed) {
      controller.reverse();
      await Future.delayed(const Duration(milliseconds: 300));
    }

    // Navigate to the login page
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    fadeController.dispose();
    for (var controller in parityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE8D5),
      body: Center(
        child: showParityList
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => FadeTransition(
                    opacity: parityAnimations[index],
                    child: Text(
                      'Parity',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloock(
                        fontSize: 48 - (index * 6), // Reduce size incrementally
                        fontWeight: FontWeight.bold,
                        color: [
                          const Color(0xFF313B40),
                          const Color(0xFF245056),
                          const Color(0xFF364C63),
                          const Color(0xFFE66A2C),
                          const Color(0xFFF3B340),
                        ][index],
                      ),
                    ),
                  ),
                ),
              )
            : FadeTransition(
                opacity: fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/paritylogo.png',
                      width: 350,
                      height: 150,
                    ),
                    Text(
                      'Parity',
                      style: GoogleFonts.gloock(
                        fontSize: 62,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF313B40),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LandingPage(),
  ));
}
//this is an app I created to be able 