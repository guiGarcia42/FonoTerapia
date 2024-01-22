import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'package:fono_terapia/shared/themes/app_text_styles.dart';

class IconButtonWithDescription extends StatelessWidget {
  final IconData icon;
  final String description;
  final VoidCallback onPressed;

  const IconButtonWithDescription({
    required this.icon,
    required this.description,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding:
                EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: AppColors.darkGray,
          ),
          child: SizedBox(
            width: 100,
            child: Center(
              child: Icon(
                icon,
                color: AppColors.background,
                size: 60,
              ),
            ),
          ),
        ),
        Text(
          description,
          style: TextStyles.buttonDescription,
        ),
      ],
    );
  }
}
