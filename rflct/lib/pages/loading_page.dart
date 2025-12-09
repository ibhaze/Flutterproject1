// ignore_for_file: unnecessary_underscores

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflct/pages/onboarding_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    // Wait 3 seconds → then navigate to HomePage with a slide-up transition
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),

          pageBuilder: (_, __, ___) =>
              const OnboardingPage(), // The page to navigate to

          transitionsBuilder: (_, animation, __, child) {
            // Defines how the transition animation looks

            final slideAnimation =
                Tween<Offset>(
                  // Slide animation: page moves from slightly below the screen → normal position
                  begin: const Offset(0, 0.15), // Start slightly lower
                  end: Offset.zero, // End at normal position
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut, // Smooth, natural movement
                  ),
                );

            // Fade animation for smooth appearance
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation);

            // Combine fade + slide
            return FadeTransition(
              opacity: fadeAnimation, 
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF663366),

      body: Center(
        child: TweenAnimationBuilder(
          // Animates a value from 0 → 1
          tween: Tween<double>(begin: 0, end: 1),

          // Animation duration
          duration: const Duration(seconds: 2),

          // Smooth easing curve
          curve: Curves.easeOut,

          // Rebuilds every frame with the animated value
          builder: (context, value, child) {
            return Opacity(
              opacity: value, // fade in

              child: Transform.scale(
                scale: value, // zoom in
                child: child,
              ),
            );
          },

          child: Text(
            'RFLCT',
            style: GoogleFonts.nunito(
              fontSize: 70,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
