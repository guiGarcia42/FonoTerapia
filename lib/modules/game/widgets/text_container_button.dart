import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';

class TextContainerButton extends StatelessWidget {
  const TextContainerButton({
    super.key,
    required this.size,
    required this.text,
    required this.onTap,
  });

  final Size size;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size.height * 0.2,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.lightOrange,
            border: Border.all(color: AppColors.darkGray, width: 3),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyles.textLargeRegular,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
