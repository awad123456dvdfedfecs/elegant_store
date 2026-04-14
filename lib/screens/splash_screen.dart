import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..forward();

    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Stack(
        children: [
          ...List.generate(30, (index) {
            return Positioned(
              top: (index * 70).toDouble() % 700,
              left: (index * 45).toDouble() % 400,
              child: Container(
                width: 1.5,
                height: 1.5,
                decoration: BoxDecoration(
                  color: const Color(0xFFC9A84C).withOpacity(0.2 + (index * 0.01)),
                  shape: BoxShape.circle,
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                .moveY(begin: -30, end: 30, duration: (1800 + (index * 80)).ms)
                .fadeIn(),
            );
          }),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC9A84C).withOpacity(0.4),
                      width: 1.2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'إ',
                      style: TextStyle(fontSize: 72, fontWeight: FontWeight.w300, color: Color(0xFFC9A84C)),
                    ),
                  ),
                ).animate().fadeIn(duration: 900.ms).scale(begin: const Offset(0.4, 0.4), curve: Curves.elasticOut),
                const SizedBox(height: 35),
                const Text(
                  'إِيلِيجَانس',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 6),
                ).animate().fadeIn(delay: 500.ms, duration: 900.ms).moveY(begin: 25, curve: Curves.easeOutCubic),
                const SizedBox(height: 10),
                Text(
                  'ELEGANCE',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: const Color(0xFFC9A84C).withOpacity(0.7), letterSpacing: 10),
                ).animate().fadeIn(delay: 700.ms, duration: 700.ms),
                const SizedBox(height: 60),
                Container(
                  width: 70,
                  height: 1.5,
                  color: const Color(0xFFC9A84C).withOpacity(0.3),
                ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1400.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}