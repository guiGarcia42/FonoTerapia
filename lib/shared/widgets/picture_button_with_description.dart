import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_text_styles.dart';

class PictureButtonWithDescription extends StatelessWidget {

  final String imagePath;
  final String description;
  final Size size;
  final VoidCallback onTap;
  
  const PictureButtonWithDescription({
    super.key,
    required this.description,
    required this.imagePath,
    required this.size,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: size.height * 0.2,
          ),
          Text(
            description,
            style: TextStyles.menuOptionDescription,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
