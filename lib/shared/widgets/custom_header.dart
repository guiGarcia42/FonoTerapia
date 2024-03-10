import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.text,
    required this.size,
  });

  final String text;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.20,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [AppColors.lightOrange, AppColors.darkOrange],
          center: Alignment.center,
          radius: 0.7,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Center(
            child: Text(
              text,
              style: TextStyles.titleAppBar,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
