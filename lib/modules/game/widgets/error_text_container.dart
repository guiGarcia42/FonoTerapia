import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';

class ErrorTextContainer extends StatelessWidget {
  const ErrorTextContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Padding build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.lightOrange,
          border: Border.all(color: AppColors.darkGray, width: 3),
        ),
        child: Center(
          child: Text(
            "Erro ao carregar",
            style: TextStyles.textLargeRegular,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
