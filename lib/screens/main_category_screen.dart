import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'sub_category_screen.dart';
import 'notifications_screen.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainCategoryScreen extends StatelessWidget {
  const MainCategoryScreen({super.key});

  void _onNavTap(BuildContext context, int index) {
    final pages = [
      const MainCategoryScreen(),
      const SearchScreen(),
      const CartScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => pages[index],
        transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('إِيلِيجَانس'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'استكشف',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w600, color: const Color(0xFF0A0A0A), letterSpacing: 1),
                  ).animate().fadeIn(duration: 600.ms).moveY(begin: 20),
                  const SizedBox(height: 8),
                  Text(
                    'عالم الأناقة الفاخرة',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey.shade600),
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                ],
              ),
            ),
            const SizedBox(height: 40),
            AnimationLimiter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMainCategoryCard(
                      context,
                      title: 'رجالي',
                      subtitle: 'MEN',
                      imageUrl: 'https://images.unsplash.com/photo-1617137968427-85924c800a22?w=800',
                      color: const Color(0xFF0A0A0A),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubCategoryScreen(gender: 'رجالي'))),
                    ),
                    const SizedBox(height: 24),
                    _buildMainCategoryCard(
                      context,
                      title: 'نسائي',
                      subtitle: 'WOMEN',
                      imageUrl: 'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=800',
                      color: const Color(0xFFC9A84C),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubCategoryScreen(gender: 'نسائي'))),
                    ),
                    const SizedBox(height: 24),
                    _buildMainCategoryCard(
                      context,
                      title: 'أطفال',
                      subtitle: 'KIDS',
                      imageUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800',
                      color: const Color(0xFF6B5B4D),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubCategoryScreen(gender: 'أطفال'))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // قسم العروض المميزة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('عروض مميزة', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF0A0A0A), Color(0xFF2A2A2A)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('خصم ٤٠٪', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFFC9A84C))),
                                const SizedBox(height: 8),
                                const Text('على جميع المنتجات الجديدة', style: TextStyle(fontSize: 16, color: Colors.white)),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFC9A84C),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  ),
                                  child: const Text('تسوق الآن', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                          child: Image.network('https://images.unsplash.com/photo-1483985988355-763728e1935b?w=300', width: 140, fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: LuxuryBottomNav(selectedIndex: 0, onTap: (index) => _onNavTap(context, index)),
    );
  }

  Widget _buildMainCategoryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String imageUrl,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimationConfiguration.staggeredGrid(
        position: 0,
        duration: const Duration(milliseconds: 600),
        columnCount: 1,
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 30, offset: const Offset(0, 8))],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(imageUrl, width: double.infinity, height: 220, fit: BoxFit.cover),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.1), Colors.transparent],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(subtitle, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: color, letterSpacing: 5)),
                        const SizedBox(height: 10),
                        Text(title, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 2)),
                        const SizedBox(height: 20),
                        Container(width: 60, height: 2, color: color),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}