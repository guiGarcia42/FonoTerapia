import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'package:fono_terapia/shared/themes/app_text_styles.dart';

class ElevatedTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Size size;


  const ElevatedTextButton({
    super.key,
    required this.size,
    required this.text,
    required this.onPressed,
  });

  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColors.darkGray,
      ),
      child: SizedBox(
        width: size.width * 0.4, 
        height: 60,
        child: Center(
          child: Text(
            text,
            style: TextStyles.buttonText,
          ),
        ),
      ),
    );
  }
}
