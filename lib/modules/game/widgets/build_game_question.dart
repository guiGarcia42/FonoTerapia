import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/modules/startup/loading_view.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

import '../../../shared/widgets/error_text_container.dart';

class BuildGameQuestion extends StatelessWidget {
  const BuildGameQuestion({
    super.key,
    required this.player,
    required this.subCategoryId,
    required this.rightAnswer,
  });

  final AudioPlayer player;
  final int subCategoryId;
  final GameComponent rightAnswer;

  @override
  Widget build(BuildContext context) {
    if ([1, 2, 3, 4, 5, 13, 14, 16, 17].contains(subCategoryId)) {
      return _buildAudioButton();
    }

    if ([6, 8, 10].contains(subCategoryId)) {
      return _buildTextContainer();
    }

    if ([7, 9, 11, 12, 15].contains(subCategoryId)) {
      return _buildImageContainer();
    }
    return ErrorTextContainer();
  }

  GestureDetector _buildAudioButton() {
    return GestureDetector(
      onTap: () {
        player.play(AssetSource(rightAnswer.audioPath), volume: 1);
      },
      child: Container(
        decoration: _customBoxDecoration(),
        child: Icon(
          Icons.volume_up_rounded,
          size: responsiveSize.scaleSize(200),
          color: AppColors.darkGray,
        ),
      ),
    );
  }

  Widget _buildTextContainer() {
    if ([8, 10].contains(subCategoryId)) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveSize.scaleSize(100),
        ),
        child: Container(
          height: responsiveSize.scaleSize(200),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.lightOrange,
            border: Border.all(color: AppColors.darkGray, width: 3),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveSize.scaleSize(30),
              ),
              child: MyText(
                rightAnswer.name,
                style: TextStyles.textLargeRegular.copyWith(
                  fontSize: responsiveSize
                      .scaleSize(TextStyles.textLargeRegular.fontSize!),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: responsiveSize.scaleSize(200),
        decoration: _customBoxDecoration(),
        child: Center(
          child: MyText(
            rightAnswer.name,
            style: TextStyles.textLargeRegular.copyWith(
              fontSize: responsiveSize
                  .scaleSize(TextStyles.textLargeRegular.fontSize!),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
  }

  Widget _buildImageContainer() {
    return Container(
      height: responsiveSize.scaleSize(200),
      decoration: _customBoxDecoration(),
      child: ClipOval(
        child: Image.asset(
          rightAnswer.imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  BoxDecoration _customBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.lightOrange,
      border: Border.all(color: AppColors.darkGray, width: 3),
    );
  }
}
