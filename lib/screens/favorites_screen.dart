import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../providers/favorites_provider.dart';
import '../widgets/luxury_product_card.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'notifications_screen.dart';
import 'main_category_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('المفضلة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          if (favoritesProvider.count > 0)
            TextButton(
              onPressed: () {
                favoritesProvider.clearFavorites();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم مسح المفضلة'), backgroundColor: Color(0xFF0A0A0A), behavior: SnackBarBehavior.floating),
                );
              },
              child: const Text('مسح الكل', style: TextStyle(color: Colors.red, fontSize: 13)),
            ),
        ],
      ),
      body: favoritesProvider.count == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, size: 100, color: Color(0xFFE0E0E0)),
                  const SizedBox(height: 20),
                  const Text('المفضلة فارغة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text('أضف منتجاتك المفضلة لتجدها بسهولة', style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            )
          : AnimationLimiter(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: favoritesProvider.favorites.length,
                itemBuilder: (context, index) {
                  final product = favoritesProvider.favorites[index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 400),
                    columnCount: 2,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: LuxuryProductCard(
                          product: product,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: LuxuryBottomNav(selectedIndex: 3, onTap: (index) => _onNavTap(context, index)),
    );
  }
}