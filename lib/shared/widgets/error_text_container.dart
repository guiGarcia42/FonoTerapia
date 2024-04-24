import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class ErrorTextContainer extends StatelessWidget {
  const ErrorTextContainer({
    super.key,
  });

  @override
  Container build(BuildContext context) {
    return Container(
      height: responsiveSize.scaleSize(80),
      width: responsiveSize.scaleSize(200),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.lightOrange,
        border: Border.all(color: AppColors.darkGray, width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: MyText(
          "Erro ao carregar",
          style: TextStyles.textLargeRegular.copyWith(
            fontSize:
                responsiveSize.scaleSize(TextStyles.textLargeRegular.fontSize!),
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
