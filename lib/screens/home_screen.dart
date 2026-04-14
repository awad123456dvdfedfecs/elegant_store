import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/app_provider.dart';
import '../widgets/luxury_product_card.dart';
import '../widgets/gender_selector.dart';
import '../widgets/category_chip.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final String selectedGender;
  const HomeScreen({super.key, required this.selectedGender});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _headerAnimationController;
  late String currentGender;
  String selectedCategory = 'الكل';
  int selectedNavIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    currentGender = widget.selectedGender == 'الكل' ? 'رجالي' : widget.selectedGender;
    _headerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Product> get filteredProducts {
    List<Product> genderProducts = currentGender == 'الكل' 
        ? allProducts 
        : allProducts.where((p) => p.gender == currentGender).toList();
    
    if (selectedCategory == 'الكل') return genderProducts;
    return genderProducts.where((p) => p.category == selectedCategory).toList();
  }

  List<String> get currentCategories {
    if (currentGender == 'الكل') {
      return ['الكل', 'بدل', 'فساتين', 'قمصان', 'أحذية', 'حقائب', 'أطفال'];
    }
    return categoriesByGender[currentGender] ?? ['الكل'];
  }

  void _onNavTap(int index) {
    if (index == selectedNavIndex) return;
    
    final pages = [
      HomeScreen(selectedGender: currentGender),
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
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text(
                  'إليجانت',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 12,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: Color(0xFF1A1A1A)),
                  onPressed: () {},
                ),
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF1A1A1A)),
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
                              color: Color(0xFFC4A882),
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
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(100),
                  child: Column(
                    children: [
                      GenderSelector(
                        selectedGender: currentGender,
                        onGenderChanged: (gender) {
                          setState(() {
                            currentGender = gender;
                            selectedCategory = 'الكل';
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Categories
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: currentCategories.length,
                        itemBuilder: (context, index) {
                          return CategoryChip(
                            label: currentCategories[index],
                            isSelected: selectedCategory == currentCategories[index],
                            onTap: () => setState(() => selectedCategory = currentCategories[index]),
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Header with count
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${filteredProducts.length} قطعة فاخرة',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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
                    
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: filteredProducts.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade300),
                              const SizedBox(height: 20),
                              Text('لا توجد منتجات', style: TextStyle(fontSize: 18, color: Colors.grey.shade600)),
                            ],
                          ),
                        ),
                      )
                    : SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
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
                          childCount: filteredProducts.length,
                        ),
                      ),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LuxuryBottomNav(
        selectedIndex: selectedNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}