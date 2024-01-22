import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';

class FloatingIconCard extends StatelessWidget {
  final IconData icon;
  
  const FloatingIconCard({
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkGray,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Icon(
            icon,
            color: AppColors.background,
          ),
        ),
      ),
    );
  }
}
