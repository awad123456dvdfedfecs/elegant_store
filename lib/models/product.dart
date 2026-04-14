class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final String category;
  final String subCategory;
  final String gender;
  final bool isNew;
  final bool isBestseller;
  final List<String> sizes;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.subCategory,
    required this.gender,
    this.isNew = false,
    this.isBestseller = false,
    this.sizes = const ['S', 'M', 'L', 'XL', 'XXL'],
  });
}

// Men Products
final List<Product> menProducts = [
  Product(id: 'm1', name: 'قميص كلاسيكي أبيض', brand: 'ELEGANCE', price: 449, imageUrl: 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400', category: 'رجالي', subCategory: 'قمصان', gender: 'رجالي', isNew: true),
  Product(id: 'm2', name: 'تيشيرت قطن فاخر', brand: 'ELEGANCE', price: 199, imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400', category: 'رجالي', subCategory: 'تيشيرتات', gender: 'رجالي', isBestseller: true),
  Product(id: 'm3', name: 'حذاء رسمي جلد', brand: 'ELEGANCE', price: 899, imageUrl: 'https://images.unsplash.com/photo-1543163521-1bf539c0165a?w=400', category: 'رجالي', subCategory: 'أحذية', gender: 'رجالي', isNew: true),
  Product(id: 'm4', name: 'جينز عصري', brand: 'ELEGANCE', price: 399, imageUrl: 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=400', category: 'رجالي', subCategory: 'جينز', gender: 'رجالي'),
  Product(id: 'm5', name: 'سترة جلدية', brand: 'ELEGANCE', price: 1499, imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400', category: 'رجالي', subCategory: 'سترات', gender: 'رجالي', isBestseller: true),
  Product(id: 'm6', name: 'بدلة رسمية', brand: 'ELEGANCE', price: 2499, imageUrl: 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400', category: 'رجالي', subCategory: 'بدل', gender: 'رجالي', isNew: true),
  Product(id: 'm7', name: 'ساعة يد فاخرة', brand: 'ELEGANCE', price: 1299, imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', category: 'رجالي', subCategory: 'إكسسوارات', gender: 'رجالي'),
  Product(id: 'm8', name: 'حزام جلد إيطالي', brand: 'ELEGANCE', price: 349, imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400', category: 'رجالي', subCategory: 'إكسسوارات', gender: 'رجالي'),
];

// Women Products
final List<Product> womenProducts = [
  Product(id: 'w1', name: 'فستان سهرة أنيق', brand: 'ELEGANCE', price: 1899, imageUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400', category: 'نسائي', subCategory: 'فساتين', gender: 'نسائي', isNew: true),
  Product(id: 'w2', name: 'بلوزة حرير', brand: 'ELEGANCE', price: 499, imageUrl: 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400', category: 'نسائي', subCategory: 'بلوزات', gender: 'نسائي', isBestseller: true),
  Product(id: 'w3', name: 'حذاء كعب عالي', brand: 'ELEGANCE', price: 799, imageUrl: 'https://images.unsplash.com/photo-1543163521-1bf539c0165a?w=400', category: 'نسائي', subCategory: 'أحذية', gender: 'نسائي', isNew: true),
  Product(id: 'w4', name: 'معطف صوف', brand: 'ELEGANCE', price: 1699, imageUrl: 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?w=400', category: 'نسائي', subCategory: 'معاطف', gender: 'نسائي'),
  Product(id: 'w5', name: 'تنورة ميدي', brand: 'ELEGANCE', price: 399, imageUrl: 'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=400', category: 'نسائي', subCategory: 'تنانير', gender: 'نسائي', isBestseller: true),
  Product(id: 'w6', name: 'حقيبة يد فاخرة', brand: 'ELEGANCE', price: 1299, imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400', category: 'نسائي', subCategory: 'حقائب', gender: 'نسائي', isNew: true),
  Product(id: 'w7', name: 'وشاح كشمير', brand: 'ELEGANCE', price: 249, imageUrl: 'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=400', category: 'نسائي', subCategory: 'إكسسوارات', gender: 'نسائي'),
  Product(id: 'w8', name: 'نظارة شمسية', brand: 'ELEGANCE', price: 599, imageUrl: 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=400', category: 'نسائي', subCategory: 'إكسسوارات', gender: 'نسائي'),
];

// Kids Products
final List<Product> kidsProducts = [
  Product(id: 'k1', name: 'طقم رياضي', brand: 'ELEGANCE KIDS', price: 249, imageUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400', category: 'أطفال', subCategory: 'أطقم', gender: 'أطفال', isNew: true),
  Product(id: 'k2', name: 'فستان بناتي', brand: 'ELEGANCE KIDS', price: 199, imageUrl: 'https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?w=400', category: 'أطفال', subCategory: 'فساتين', gender: 'أطفال', isBestseller: true),
  Product(id: 'k3', name: 'تيشيرت ملون', brand: 'ELEGANCE KIDS', price: 99, imageUrl: 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=400', category: 'أطفال', subCategory: 'تيشيرتات', gender: 'أطفال'),
  Product(id: 'k4', name: 'جاكيت شتوي', brand: 'ELEGANCE KIDS', price: 299, imageUrl: 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=400', category: 'أطفال', subCategory: 'جاكيتات', gender: 'أطفال', isNew: true),
  Product(id: 'k5', name: 'حذاء رياضي', brand: 'ELEGANCE KIDS', price: 179, imageUrl: 'https://images.unsplash.com/photo-1514989940723-e8e51635b782?w=400', category: 'أطفال', subCategory: 'أحذية', gender: 'أطفال'),
  Product(id: 'k6', name: 'بيجامة قطن', brand: 'ELEGANCE KIDS', price: 129, imageUrl: 'https://images.unsplash.com/photo-1522771930-78848d9293e8?w=400', category: 'أطفال', subCategory: 'بيجامات', gender: 'أطفال', isBestseller: true),
];

final List<Product> allProducts = [...menProducts, ...womenProducts, ...kidsProducts];

final Map<String, List<String>> subCategoriesByGender = {
  'رجالي': ['الكل', 'قمصان', 'تيشيرتات', 'جينز', 'بدل', 'سترات', 'أحذية', 'إكسسوارات'],
  'نسائي': ['الكل', 'فساتين', 'بلوزات', 'تنانير', 'معاطف', 'أحذية', 'حقائب', 'إكسسوارات'],
  'أطفال': ['الكل', 'أطقم', 'فساتين', 'تيشيرتات', 'جاكيتات', 'أحذية', 'بيجامات'],
};