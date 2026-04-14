import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> _notifications = const [
    {'title': 'عرض خاص', 'body': 'خصم 30% على جميع المنتجات الجديدة', 'time': 'الآن', 'icon': Icons.local_offer, 'color': Color(0xFFC9A84C), 'isRead': false},
    {'title': 'تأكيد الطلب', 'body': 'تم تأكيد طلبك رقم #E2345', 'time': 'منذ ساعتين', 'icon': Icons.check_circle, 'color': Color(0xFF4CAF50), 'isRead': true},
    {'title': 'توصيل مجاني', 'body': 'توصيل مجاني للطلبات فوق 300 ريال', 'time': 'منذ 5 ساعات', 'icon': Icons.local_shipping, 'color': Color(0xFF2196F3), 'isRead': true},
    {'title': 'منتج في المفضلة', 'body': 'المنتج "قميص كلاسيكي" انخفض سعره', 'time': 'أمس', 'icon': Icons.favorite, 'color': Color(0xFFE91E63), 'isRead': false},
    {'title': 'ترحيب', 'body': 'أهلاً بك في إليجانس، استمتع بتجربة تسوق فاخرة', 'time': 'منذ يومين', 'icon': Icons.waving_hand, 'color': Color(0xFFC9A84C), 'isRead': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('تحديد الكل كمقروء', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 13)),
          ),
        ],
      ),
      body: AnimationLimiter(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final notif = _notifications[index];
            final bool isRead = notif['isRead'] as bool;
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 400),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: RepaintBoundary(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isRead ? Colors.white : const Color(0xFFFDF8F0),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200, width: 0.8),
                        boxShadow: [
                          if (!isRead)
                            BoxShadow(
                              color: const Color(0xFFC9A84C).withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: (notif['color'] as Color).withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(notif['icon'] as IconData, color: notif['color'] as Color, size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      notif['title'] as String,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                                        color: const Color(0xFF0A0A0A),
                                      ),
                                    ),
                                    const Spacer(),
                                    if (!isRead)
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFC9A84C),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  notif['body'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  notif['time'] as String,
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}