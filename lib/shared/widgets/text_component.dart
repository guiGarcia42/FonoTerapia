import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class TextComponent extends StatelessWidget {
  const TextComponent({
    super.key,
    required this.onTap,
    required this.component,
  });

  final Function(GameComponent?) onTap;
  final GameComponent component;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(component),
      child: Container(
        height: responsiveSize.scaleSize(100),
        width: responsiveSize.scaleSize(150),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.lightOrange,
          border: Border.all(color: AppColors.darkGray, width: 3),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: MyText(
            component.name,
            style: TextStyles.textLargeRegular.copyWith(
              fontSize: responsiveSize
                  .scaleSize(TextStyles.textLargeRegular.fontSize!),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
