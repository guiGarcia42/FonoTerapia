import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/utils/responsive_size.dart';

class IconButtonWithDescription extends StatelessWidget {
  final IconData icon;
  final String description;
  final Color color;
  final VoidCallback onPressed;

  const IconButtonWithDescription({
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
              width: ResponsiveSize.of(context).scaleSize(120),
              height: ResponsiveSize.of(context).scaleSize(80),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.background,
                  size: ResponsiveSize.of(context).scaleSize(80),
                ),
              ),
            ),
          ),
        ),
        Text(
          description,
          style: TextStyles.buttonDescription.copyWith(
            fontSize: responsiveSize.scaleSize(TextStyles.buttonDescription.fontSize!),
          ),
        ),
      ],
    );
  }
}
