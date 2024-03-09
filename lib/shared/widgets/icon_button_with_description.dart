import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';

class IconButtonWithDescription extends StatelessWidget {
  final Size size;
  final IconData icon;
  final String description;
  final Color color;
  final VoidCallback onPressed;

  const IconButtonWithDescription({
    required this.size,
    required this.icon,
    required this.description,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.darkGray,
              width: 3,
            ),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 10,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: color,
            ),
            child: SizedBox(
              width: size.width * 0.25,
              height: size.width * 0.2,
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.background,
                  size: size.height * 0.08,
                ),
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
