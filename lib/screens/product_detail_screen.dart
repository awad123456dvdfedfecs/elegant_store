import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = 'M';
  String selectedColor = 'أسود';
  int quantity = 1;

  final List<Map<String, dynamic>> _availableColors = [
    {'name': 'أسود', 'color': const Color(0xFF0A0A0A)},
    {'name': 'أبيض', 'color': const Color(0xFFF5F5F5)},
    {'name': 'بني', 'color': const Color(0xFF8B7355)},
    {'name': 'ذهبي', 'color': const Color(0xFFC9A84C)},
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(widget.product.id);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'product-${widget.product.id}',
                  child: Container(
                    height: 480,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.product.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: const Color(0xFFF0F0F0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.brand,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 3,
                              color: Color(0xFFC9A84C))),
                      const SizedBox(height: 8),
                      Text(widget.product.name,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              height: 1.2)),
                      const SizedBox(height: 12),
                      Text('${widget.product.price.toStringAsFixed(0)} ريال',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                          const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                          const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                          const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                          const Icon(Icons.star_half, color: Color(0xFFFFC107), size: 20),
                          const SizedBox(width: 8),
                          Text('(4.5) 125 تقييم', style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('الوصف',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Text(
                              'منتج فاخر مصنوع يدويًا من أجود الخامات العالمية. تصميم أنيق يناسب جميع المناسبات الرسمية وغير الرسمية. متوفر بمقاسات متعددة وألوان راقية.',
                              style: TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text('اللون',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: _availableColors.map((colorMap) {
                          final String name = colorMap['name'] as String;
                          final Color color = colorMap['color'] as Color;
                          final bool isSelected = selectedColor == name;
                          return GestureDetector(
                            onTap: () => setState(() => selectedColor = name),
                            child: AnimatedContainer(
                              duration: 200.ms,
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF0A0A0A)
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 30),
                      const Text('المقاس',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: widget.product.sizes.map((size) {
                          final bool isSelected = selectedSize == size;
                          return GestureDetector(
                            onTap: () => setState(() => selectedSize = size),
                            child: Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF0A0A0A)
                                    : Colors.white,
                                border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF0A0A0A)
                                        : Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(size,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF0A0A0A))),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Text('الكمية',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          const Spacer(),
                          Container(
                            width: 140,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (quantity > 1) {
                                      setState(() => quantity--);
                                    }
                                  },
                                  child: Container(
                                      width: 45,
                                      child: const Icon(Icons.remove, size: 18)),
                                ),
                                Text('$quantity',
                                    style: const TextStyle(fontSize: 16)),
                                GestureDetector(
                                  onTap: () => setState(() => quantity++),
                                  child: Container(
                                      width: 45,
                                      child: const Icon(Icons.add, size: 18)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            for (var i = 0; i < quantity; i++) {
                              cartProvider.addItem(widget.product,
                                  size: selectedSize);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('تمت الإضافة إلى السلة',
                                    style: TextStyle(color: Colors.white)),
                                backgroundColor: const Color(0xFF0A0A0A),
                                behavior: SnackBarBehavior.floating,
                                duration: 2.seconds,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A0A0A),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Text('إضافة إلى السلة',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child:
                          const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            favoritesProvider.toggleFavorite(widget.product),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? Colors.red
                                  : const Color(0xFF0A0A0A)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.share_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}