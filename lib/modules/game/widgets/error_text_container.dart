import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';

class ErrorTextContainer extends StatelessWidget {
  const ErrorTextContainer({
    super.key,
  });

  @override
  Padding build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        responsiveSize.scaleSize(20),
      ),
      child: Container(
        height: responsiveSize.scaleSize(200),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.lightOrange,
          border: Border.all(color: AppColors.darkGray, width: 3),
        ),
        child: Center(
          child: Text(
            "Erro ao carregar",
            style: TextStyles.textLargeRegular.copyWith(
              fontSize: responsiveSize
                  .scaleSize(TextStyles.textLargeRegular.fontSize!),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
