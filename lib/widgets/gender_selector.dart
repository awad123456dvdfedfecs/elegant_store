import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final Function(String) onGenderChanged;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final genders = ['رجالي', 'نسائي', 'أولادي', 'الكل'];
    
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: genders.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final gender = genders[index];
          final isSelected = selectedGender == gender;
          
          IconData icon;
          switch (gender) {
            case 'رجالي':
              icon = Icons.man;
              break;
            case 'نسائي':
              icon = Icons.woman;
              break;
            case 'أولادي':
              icon = Icons.child_care;
              break;
            default:
              icon = Icons.people_outline;
          }
          
          return GestureDetector(
            onTap: () => onGenderChanged(gender),
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF8B7355) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? const Color(0xFF8B7355) : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    gender,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(
            duration: 400.ms,
            delay: (50 * index).ms,
          ).slideX(begin: 0.2);
        },
      ),
    );
  }
}