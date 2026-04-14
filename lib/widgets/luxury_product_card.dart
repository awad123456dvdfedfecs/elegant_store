import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';

class LuxuryProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const LuxuryProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: 'product-${product.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (_, __) => Container(color: const Color(0xFFF0F0F0)),
                      errorWidget: (_, __, ___) => Container(color: const Color(0xFFF0F0F0), child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.brand, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFFC9A84C), letterSpacing: 1), maxLines: 1),
                    const SizedBox(height: 4),
                    Text(product.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0A0A0A)), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Text('${product.price.toStringAsFixed(0)} ريال', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF0A0A0A))),
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