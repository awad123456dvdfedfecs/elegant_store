import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/luxury_product_card.dart';
import '../widgets/luxury_bottom_nav.dart';
import 'notifications_screen.dart';
import 'main_category_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  String _searchQuery = '';
  String _selectedSort = 'الأحدث';
  int _selectedNavIndex = 1;

  final List<String> _recentSearches = ['قميص', 'فستان', 'حذاء', 'جينز'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = allProducts.where((product) {
          return product.name.toLowerCase().contains(query.toLowerCase()) ||
                 product.brand.toLowerCase().contains(query.toLowerCase()) ||
                 product.subCategory.toLowerCase().contains(query.toLowerCase());
        }).toList();
        _sortResults();
      }
    });
  }

  void _sortResults() {
    if (_selectedSort == 'الأحدث') {
      _searchResults.sort((a, b) => b.isNew ? 1 : -1);
    } else if (_selectedSort == 'السعر: من الأعلى للأقل') {
      _searchResults.sort((a, b) => b.price.compareTo(a.price));
    } else if (_selectedSort == 'السعر: من الأقل للأعلى') {
      _searchResults.sort((a, b) => a.price.compareTo(b.price));
    }
  }

  void _onNavTap(int index) {
    if (index == _selectedNavIndex) return;
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
        title: const Text('بحث'),
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
                    child: Text('${cartProvider.itemCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFC9A84C)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      ),
      body: _searchQuery.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('عمليات البحث الأخيرة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _recentSearches.map((term) {
                      return GestureDetector(
                        onTap: () {
                          _searchController.text = term;
                          _performSearch(term);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(term, style: const TextStyle(fontSize: 14)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Text('الأكثر بحثاً', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  ...allProducts.take(4).map((p) => ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(p.imageUrl)),
                    title: Text(p.name),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)));
                    },
                  )),
                ],
              ),
            )
          : _searchResults.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 80, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text('لا توجد نتائج لـ "$_searchQuery"', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_searchResults.length} نتيجة', style: TextStyle(color: Colors.grey.shade600)),
                          DropdownButton<String>(
                            value: _selectedSort,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFC9A84C)),
                            items: ['الأحدث', 'السعر: من الأعلى للأقل', 'السعر: من الأقل للأعلى'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedSort = value!;
                                _sortResults();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AnimationLimiter(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final product = _searchResults[index];
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
      bottomNavigationBar: LuxuryBottomNav(selectedIndex: _selectedNavIndex, onTap: _onNavTap),
    );
  }
}