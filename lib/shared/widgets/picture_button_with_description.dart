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
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
            ),
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
