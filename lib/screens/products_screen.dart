import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/luxury_product_card.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'notifications_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'product_detail_screen.dart';
import 'main_category_screen.dart';

class ProductsScreen extends StatefulWidget {
  final String gender;
  final String subCategory;
  const ProductsScreen({super.key, required this.gender, required this.subCategory});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedSort = 'الأحدث';
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  bool _showFilter = false;

  List<Product> get _products {
    List<Product> source;
    switch (widget.gender) {
      case 'رجالي': source = menProducts; break;
      case 'نسائي': source = womenProducts; break;
      case 'أطفال': source = kidsProducts; break;
      default: source = [];
    }
    var filtered = widget.subCategory == 'الكل' ? source : source.where((p) => p.subCategory == widget.subCategory).toList();
    if (_minPriceController.text.isNotEmpty) {
      final min = double.tryParse(_minPriceController.text) ?? 0;
      filtered = filtered.where((p) => p.price >= min).toList();
    }
    if (_maxPriceController.text.isNotEmpty) {
      final max = double.tryParse(_maxPriceController.text) ?? double.infinity;
      filtered = filtered.where((p) => p.price <= max).toList();
    }
    if (_selectedSort == 'الأحدث') {
      filtered.sort((a, b) => b.isNew ? 1 : -1);
    } else if (_selectedSort == 'السعر: من الأعلى للأقل') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (_selectedSort == 'السعر: من الأقل للأعلى') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    }
    return filtered;
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
    final cartProvider = Provider.of<CartProvider>(context);
    final products = _products;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.subCategory),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  left: 8, top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Color(0xFFC9A84C), shape: BoxShape.circle),
                    child: Text('${cartProvider.itemCount}', style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSort,
                        isExpanded: true,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        items: ['الأحدث', 'السعر: من الأعلى للأقل', 'السعر: من الأقل للأعلى'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => setState(() => _selectedSort = v!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => setState(() => _showFilter = !_showFilter),
                  icon: const Icon(Icons.filter_list),
                  label: const Text('تصفية'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showFilter ? const Color(0xFFC9A84C) : Colors.white,
                    foregroundColor: _showFilter ? Colors.white : const Color(0xFF0A0A0A),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
          if (_showFilter)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'السعر الأدنى', border: OutlineInputBorder()),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'السعر الأقصى', border: OutlineInputBorder()),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: products.isEmpty
                ? const Center(child: Text('لا توجد منتجات'))
                : AnimationLimiter(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
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
          ),
        ],
      ),
      bottomNavigationBar: LuxuryBottomNav(selectedIndex: 0, onTap: (index) => _onNavTap(context, index)),
    );
  }
}