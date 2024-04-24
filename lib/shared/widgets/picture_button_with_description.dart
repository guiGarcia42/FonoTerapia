import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class PictureButtonWithDescription extends StatelessWidget {
  final String imagePath;
  final String description;
  final VoidCallback onTap;

  const PictureButtonWithDescription(
      {super.key,
      required this.description,
      required this.imagePath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: responsiveSize.scaleSize(TextStyles.textLargeRegular.fontSize! * 3),
            child: MyText(
              description,
              style: TextStyles.textLargeRegular.copyWith(
                fontSize: responsiveSize.scaleSize(TextStyles.textLargeRegular.fontSize!),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
