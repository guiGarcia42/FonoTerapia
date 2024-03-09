import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';

class ProgressIndicatorWithPercentageText extends StatelessWidget {
  const ProgressIndicatorWithPercentageText({
    super.key,
    required this.percentage,
  });

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.darkGray,
            width: 3,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                minHeight: 50,
                value: percentage / 100,
                valueColor: AlwaysStoppedAnimation(
                    AppColors.right),
                backgroundColor: AppColors.background,
              ),
            ),
            Text(
              '${percentage.toInt()}% Correto',
              style: TextStyles.textRegular,
            ),
          ],
        ),
      ),
    );
  }
}
