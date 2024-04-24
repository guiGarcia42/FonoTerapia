import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: responsiveSize.width,
      height: responsiveSize.height * 0.2,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [AppColors.lightOrange, AppColors.darkOrange],
          center: Alignment.center,
          radius: 0.7,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveSize.scaleSize(50),
          ),
          child: Center(
            child: MyText(
              text,
              style: TextStyles.title.copyWith(
                fontSize: responsiveSize.scaleSize(TextStyles.title.fontSize!),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
