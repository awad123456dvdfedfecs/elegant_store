import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/luxury_product_card.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'product_detail_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String gender;
  const CategoryProductsScreen({super.key, required this.gender});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  String selectedSubCategory = 'الكل';
  int selectedNavIndex = 0;

  List<Product> get categoryProducts {
    switch (widget.gender) {
      case 'رجالي':
        return menProducts;
      case 'نسائي':
        return womenProducts;
      case 'أطفال':
        return kidsProducts;
      default:
        return [];
    }
  }

  List<Product> get filteredProducts {
    if (selectedSubCategory == 'الكل') {
      return categoryProducts;
    }
    return categoryProducts.where((p) => p.subCategory == selectedSubCategory).toList();
  }

  List<String> get subCategories {
    return subCategoriesByGender[widget.gender] ?? ['الكل'];
  }

  void _onNavTap(int index) {
    if (index == selectedNavIndex) return;
    
    final pages = [
      CategoryProductsScreen(gender: widget.gender),
      const SearchScreen(),
      const CartScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];
    
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => pages[index],
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final genderTitle = widget.gender == 'رجالي' ? 'MEN' : widget.gender == 'نسائي' ? 'WOMEN' : 'KIDS';
    final genderArabic = widget.gender;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              genderTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                letterSpacing: 6,
                color: Color(0xFFD4AF37),
              ),
            ),
            Text(
              genderArabic,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD4AF37),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Sub Categories
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                final subCategory = subCategories[index];
                final isSelected = selectedSubCategory == subCategory;
                return GestureDetector(
                  onTap: () => setState(() => selectedSubCategory = subCategory),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF1A1A1A) : Colors.white,
                      border: Border.all(
                        color: isSelected ? const Color(0xFF1A1A1A) : Colors.grey.shade300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        subCategory,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: (50 * index).ms);
              },
            ),
          ),
          
          // Products Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredProducts.length} قطعة',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list, size: 20),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.sort, size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Products Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade300),
                        const SizedBox(height: 20),
                        Text('لا توجد منتجات', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                      ],
                    ),
                  )
                : AnimationLimiter(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: 2,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: LuxuryProductCard(
                                product: product,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 500),
                                      pageBuilder: (_, __, ___) => ProductDetailScreen(product: product),
                                      transitionsBuilder: (_, animation, __, child) {
                                        return FadeTransition(opacity: animation, child: child);
                                      },
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
          ),
        ],
      ),
      bottomNavigationBar: LuxuryBottomNav(
        selectedIndex: selectedNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}