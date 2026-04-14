import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'main_category_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {
        _isButtonEnabled = _phoneController.text.length >= 9;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _continueAsGuest() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const MainCategoryScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFC9A84C), width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('إ', style: TextStyle(fontSize: 32, color: Color(0xFFC9A84C))),
                  ),
                ).animate().fadeIn(duration: 600.ms).scale(),
              ),
              const SizedBox(height: 40),
              Text(
                'أهلاً بك',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Color(0xFF0A0A0A)),
              ).animate().fadeIn(delay: 200.ms).moveY(begin: 15),
              const SizedBox(height: 12),
              Text(
                'قم بتسجيل الدخول للمتابعة',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 18, letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: 'رقم الجوال',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade400),
                    prefixIcon: const Icon(Icons.phone_outlined, color: Color(0xFFC9A84C)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.1),
              const SizedBox(height: 30),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: _isButtonEnabled ? const Color(0xFF0A0A0A) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(
                    'المتابعة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _isButtonEnabled ? Colors.white : Colors.grey.shade500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('أو', style: TextStyle(color: Colors.grey.shade500)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: _continueAsGuest,
                  style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14)),
                  child: Text(
                    'المتابعة كزائر',
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color(0xFFC9A84C),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFC9A84C).withOpacity(0.5),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 700.ms),
              const Spacer(),
              Center(
                child: Text(
                  'بالمتابعة، أنت توافق على الشروط والأحكام',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ).animate().fadeIn(delay: 800.ms),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}