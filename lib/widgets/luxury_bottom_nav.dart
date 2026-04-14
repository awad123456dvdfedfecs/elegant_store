import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LuxuryBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const LuxuryBottomNav({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 0.5)),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: const Color(0xFF1A1A1A),
        unselectedItemColor: Colors.grey.shade400,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, letterSpacing: 0.5),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 22), activeIcon: Icon(Icons.home, size: 22), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined, size: 22), activeIcon: Icon(Icons.search, size: 22), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined, size: 22), activeIcon: Icon(Icons.shopping_bag, size: 22), label: 'السلة'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border, size: 22), activeIcon: Icon(Icons.favorite, size: 22), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 22), activeIcon: Icon(Icons.person, size: 22), label: 'حسابي'),
        ],
      ),
    ).animate().slideY(begin: 1, end: 0, duration: const Duration(milliseconds: 600), curve: Curves.easeOutCubic);
  }
}