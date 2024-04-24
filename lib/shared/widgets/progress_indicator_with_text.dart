import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class ProgressIndicatorWithText extends StatelessWidget {
  const ProgressIndicatorWithText({
    super.key,
    required this.answeredCorrectly,
    required this.totalNumberOfQuestions,
  });

  final int answeredCorrectly;
  final int totalNumberOfQuestions;

  @override
  Widget build(BuildContext context) {
    final double percentage = (answeredCorrectly / totalNumberOfQuestions) * 100;

    return Container(
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
              valueColor: AlwaysStoppedAnimation(AppColors.right),
              backgroundColor: AppColors.background,
            ),
          ),
          MyText(
            '$answeredCorrectly/$totalNumberOfQuestions Acertos',
            style: TextStyles.textRegular,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
