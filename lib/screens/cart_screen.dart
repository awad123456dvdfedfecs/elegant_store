import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/cart_provider.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'notifications_screen.dart';
import 'main_category_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('سلة التسوق'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          if (cartProvider.itemCount > 0)
            TextButton(
              onPressed: () {
                cartProvider.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم مسح السلة'), backgroundColor: Color(0xFF0A0A0A), behavior: SnackBarBehavior.floating),
                );
              },
              child: const Text('مسح الكل', style: TextStyle(color: Colors.red, fontSize: 13)),
            ),
        ],
      ),
      body: cartProvider.itemCount == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 100, color: Colors.grey.shade300).animate().scale(duration: 500.ms),
                  const SizedBox(height: 20),
                  const Text('سلة التسوق فارغة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF0A0A0A))),
                  const SizedBox(height: 8),
                  Text('استكشف منتجاتنا وأضف ما يعجبك', style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainCategoryScreen())),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A0A0A), padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: const Text('ابدأ التسوق', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartProvider.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = cartProvider.items[index];
                      return Dismissible(
                        key: ValueKey(item.product.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          color: Colors.red.shade50,
                          child: const Icon(Icons.delete_outline, color: Colors.red),
                        ),
                        onDismissed: (_) => cartProvider.removeItem(item.product.id),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: item.product))),
                                child: Hero(
                                  tag: 'cart-${item.product.id}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(item.product.imageUrl, width: 80, height: 100, fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.product.brand, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFFC9A84C))),
                                    const SizedBox(height: 4),
                                    Text(item.product.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600), maxLines: 1),
                                    const SizedBox(height: 6),
                                    Text('${item.totalPrice.toStringAsFixed(0)} ريال', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF0A0A0A))),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () => cartProvider.updateQuantity(item.product.id, item.quantity - 1),
                                                child: const SizedBox(width: 32, height: 32, child: Icon(Icons.remove, size: 16)),
                                              ),
                                              Text('${item.quantity}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                              GestureDetector(
                                                onTap: () => cartProvider.updateQuantity(item.product.id, item.quantity + 1),
                                                child: const SizedBox(width: 32, height: 32, child: Icon(Icons.add, size: 16)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Text('المقاس: ${item.selectedSize}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: (50 * index).ms).slideX(begin: 0.1, curve: Curves.easeOutCubic);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey.shade200)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, -2))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('الإجمالي', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          Text('${cartProvider.totalAmount.toStringAsFixed(0)} ريال', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFFC9A84C))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A0A0A),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: const Text('إتمام الشراء', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: LuxuryBottomNav(selectedIndex: 2, onTap: (index) => _onNavTap(context, index)),
    );
  }
}