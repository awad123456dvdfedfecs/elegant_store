import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'الأناقة الرجالية',
      'subtitle': 'اكتشف مجموعة حصرية من أفخم الأزياء الرجالية',
      'gradient': [Color(0xFF1A1A1A), Color(0xFF2C2C2C)],
      'image': 'https://images.unsplash.com/photo-1617137968427-85924c800a22?w=1200',
    },
    {
      'title': 'الأنوثة الفاخرة',
      'subtitle': 'تشكيلة راقية تعكس جوهر الأناقة النسائية',
      'gradient': [Color(0xFFC4A882), Color(0xFF8B7355)],
      'image': 'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=1200',
    },
    {
      'title': 'عالم الأطفال',
      'subtitle': 'ملابس فاخرة لأطفالكم بأعلى معايير الجودة',
      'gradient': [Color(0xFF6B5B4D), Color(0xFF4A3F35)],
      'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=1200',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildPage(index);
            },
          ),
          
          // Top navigation
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => _navigateToHome(),
                    child: Text(
                      'تخطي',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: WormEffect(
                      activeDotColor: Colors.white,
                      dotColor: Colors.white.withOpacity(0.3),
                      dotHeight: 6,
                      dotWidth: 20,
                      spacing: 8,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOutCubic,
                        );
                      } else {
                        _navigateToHome();
                      }
                    },
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'ابدأ' : 'التالي',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    final page = _pages[index];
    
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(page['image']),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.darken,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ],
            stops: const [0.5, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Text(
                    page['title'],
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                      letterSpacing: 4,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .moveY(begin: 30, curve: Curves.easeOutCubic),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    page['subtitle'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .moveY(begin: 20, curve: Curves.easeOutCubic),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => const HomeScreen(selectedGender: 'الكل'),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          );
        },
      ),
    );
  }
}