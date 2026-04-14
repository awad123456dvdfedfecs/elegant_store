import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'notifications_screen.dart';
import 'main_category_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        title: const Text('حسابي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFC9A84C), width: 1.5),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200'),
              ),
            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            const SizedBox(height: 18),
            const Text('أحمد محمد', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text('ahmed@elegance.com', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
            const SizedBox(height: 30),
            _buildStatRow(),
            const SizedBox(height: 30),
            _buildMenuSection('الحساب', [
              _MenuItem(icon: Icons.person_outline, title: 'ملفي الشخصي', onTap: () {}),
              _MenuItem(icon: Icons.location_on_outlined, title: 'العناوين', onTap: () {}),
              _MenuItem(icon: Icons.payment_outlined, title: 'طرق الدفع', onTap: () {}),
            ]),
            _buildMenuSection('الطلبات', [
              _MenuItem(icon: Icons.shopping_bag_outlined, title: 'طلباتي', onTap: () {}),
              _MenuItem(icon: Icons.history, title: 'سجل الطلبات', onTap: () {}),
            ]),
            _buildMenuSection('الإعدادات', [
              _MenuItem(icon: Icons.notifications_outlined, title: 'الإشعارات', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
              _MenuItem(icon: Icons.language, title: 'اللغة', trailing: 'العربية', onTap: () {}),
              _MenuItem(icon: Icons.help_outline, title: 'المساعدة والدعم', onTap: () {}),
              _MenuItem(icon: Icons.info_outline, title: 'عن التطبيق', onTap: () {}),
            ]),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: LuxuryBottomNav(selectedIndex: 4, onTap: (index) => _onNavTap(context, index)),
    );
  }

  Widget _buildStatRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat('12', 'طلبية'),
          Container(width: 1, height: 30, color: Colors.grey.shade300),
          _buildStat('5', 'قيد التوصيل'),
          Container(width: 1, height: 30, color: Colors.grey.shade300),
          _buildStat('3', 'مرتجعات'),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFFC9A84C))),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        ...items.map((item) => ListTile(
          leading: Icon(item.icon, color: const Color(0xFFC9A84C)),
          title: Text(item.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item.trailing != null) Text(item.trailing!, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, size: 14),
            ],
          ),
          onTap: item.onTap,
        )).toList(),
        const Divider(height: 1),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.title, this.trailing, required this.onTap});
}