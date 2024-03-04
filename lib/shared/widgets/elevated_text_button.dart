import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';

class ElevatedTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double widthRatio;
  final TextStyle textStyle;


  const ElevatedTextButton({
    super.key,
    required this.widthRatio,
    required this.text,
    required this.onPressed,
    required this.textStyle
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
        width: widthRatio, 
        height: 50,
        child: Center(
          child: Text(
            text,
            style: textStyle,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
