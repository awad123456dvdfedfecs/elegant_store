import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/product.dart';
import 'products_screen.dart';
import 'notifications_screen.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'main_category_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  final String gender;
  const SubCategoryScreen({super.key, required this.gender});

  List<Map<String, dynamic>> get _subCategories {
    switch (gender) {
      case 'رجالي':
        return [
          {'title': 'قمصان', 'icon': Icons.checkroom, 'count': menProducts.where((p) => p.subCategory == 'قمصان').length, 'image': 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400'},
          {'title': 'تيشيرتات', 'icon': Icons.style, 'count': menProducts.where((p) => p.subCategory == 'تيشيرتات').length, 'image': 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400'},
          {'title': 'جينز', 'icon': Icons.checkroom, 'count': menProducts.where((p) => p.subCategory == 'جينز').length, 'image': 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=400'},
          {'title': 'بدل', 'icon': Icons.business, 'count': menProducts.where((p) => p.subCategory == 'بدل').length, 'image': 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400'},
          {'title': 'سترات', 'icon': Icons.checkroom, 'count': menProducts.where((p) => p.subCategory == 'سترات').length, 'image': 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400'},
          {'title': 'أحذية', 'icon': Icons.hiking, 'count': menProducts.where((p) => p.subCategory == 'أحذية').length, 'image': 'https://images.unsplash.com/photo-1543163521-1bf539c0165a?w=400'},
          {'title': 'إكسسوارات', 'icon': Icons.watch, 'count': menProducts.where((p) => p.subCategory == 'إكسسوارات').length, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400'},
        ];
      case 'نسائي':
        return [
          {'title': 'فساتين', 'icon': Icons.checkroom, 'count': womenProducts.where((p) => p.subCategory == 'فساتين').length, 'image': 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400'},
          {'title': 'بلوزات', 'icon': Icons.style, 'count': womenProducts.where((p) => p.subCategory == 'بلوزات').length, 'image': 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400'},
          {'title': 'تنانير', 'icon': Icons.checkroom, 'count': womenProducts.where((p) => p.subCategory == 'تنانير').length, 'image': 'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=400'},
          {'title': 'معاطف', 'icon': Icons.checkroom, 'count': womenProducts.where((p) => p.subCategory == 'معاطف').length, 'image': 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?w=400'},
          {'title': 'أحذية', 'icon': Icons.hiking, 'count': womenProducts.where((p) => p.subCategory == 'أحذية').length, 'image': 'https://images.unsplash.com/photo-1543163521-1bf539c0165a?w=400'},
          {'title': 'حقائب', 'icon': Icons.shopping_bag, 'count': womenProducts.where((p) => p.subCategory == 'حقائب').length, 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400'},
          {'title': 'إكسسوارات', 'icon': Icons.watch, 'count': womenProducts.where((p) => p.subCategory == 'إكسسوارات').length, 'image': 'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=400'},
        ];
      default:
        return [
          {'title': 'أطقم', 'icon': Icons.checkroom, 'count': kidsProducts.where((p) => p.subCategory == 'أطقم').length, 'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400'},
          {'title': 'فساتين', 'icon': Icons.checkroom, 'count': kidsProducts.where((p) => p.subCategory == 'فساتين').length, 'image': 'https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?w=400'},
          {'title': 'تيشيرتات', 'icon': Icons.style, 'count': kidsProducts.where((p) => p.subCategory == 'تيشيرتات').length, 'image': 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=400'},
          {'title': 'جاكيتات', 'icon': Icons.checkroom, 'count': kidsProducts.where((p) => p.subCategory == 'جاكيتات').length, 'image': 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=400'},
          {'title': 'أحذية', 'icon': Icons.hiking, 'count': kidsProducts.where((p) => p.subCategory == 'أحذية').length, 'image': 'https://images.unsplash.com/photo-1514989940723-e8e51635b782?w=400'},
          {'title': 'بيجامات', 'icon': Icons.bed, 'count': kidsProducts.where((p) => p.subCategory == 'بيجامات').length, 'image': 'https://images.unsplash.com/photo-1522771930-78848d9293e8?w=400'},
        ];
    }
  }

  String get _genderTitle {
    switch (gender) {
      case 'رجالي': return 'MEN';
      case 'نسائي': return 'WOMEN';
      default: return 'KIDS';
    }
  }

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
        title: Column(
          children: [
            Text(_genderTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 6, color: Color(0xFFC9A84C))),
            Text(gender, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF0A0A0A))),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
        ],
      ),
      body: AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.1,
          ),
          itemCount: _subCategories.length,
          itemBuilder: (context, index) {
            final sub = _subCategories[index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: 2,
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _buildSubCategoryCard(
                    context,
                    title: sub['title'],
                    icon: sub['icon'],
                    count: sub['count'],
                    imageUrl: sub['image'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductsScreen(gender: gender, subCategory: sub['title']),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: LuxuryBottomNav(selectedIndex: 0, onTap: (index) => _onNavTap(context, index)),
    );
  }

  Widget _buildSubCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required int count,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 4))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(imageUrl, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(icon, color: Colors.white, size: 24),
                    const SizedBox(height: 8),
                    Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text('$count قطعة', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}