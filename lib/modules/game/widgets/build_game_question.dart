import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';

import 'error_text_container.dart';

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
    if ([1, 2, 3, 4, 8, 13, 14].contains(subCategoryId)) {
      return _buildAudioButton();
    }

    if ([5, 7, 11].contains(subCategoryId)) {
      if ([11].contains(subCategoryId)) {
        return _buildTextContainer(true);
      } else {
        return _buildTextContainer(false);
      }
    }

    if ([6, 9, 10, 12].contains(subCategoryId)) {
      return _buildImageContainer();
    }
    return ErrorTextContainer();
  }

  GestureDetector _buildAudioButton() {
    return GestureDetector(
      onTap: () {
        player.play(AssetSource(rightAnswer.audioPath));
      },
      child: Container(
        decoration: _customBoxDecoration(),
        child: Icon(
          Icons.volume_up_rounded,
          size: responsiveSize.scaleSize(250),
          color: AppColors.darkGray,
        ),
      ),
    );
  }

  Widget _buildTextContainer(bool playAudio) {
    if (playAudio) {
      player.play(AssetSource(rightAnswer.audioPath));

      return InkWell(
        onTap: () => player.play(AssetSource(rightAnswer.audioPath)),
        child: Container(
          height: responsiveSize.scaleSize(250),
          decoration: _customBoxDecoration(),
          child: Center(
            child: Text(
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
        ),
      );
    } else if ([7].contains(subCategoryId)) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveSize.scaleSize(100),
        ),
        child: Container(
          height: responsiveSize.scaleSize(250),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.lightOrange,
            border: Border.all(color: AppColors.darkGray, width: 3),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveSize.scaleSize(30),
              ),
              child: Text(
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
        height: responsiveSize.scaleSize(250),
        decoration: _customBoxDecoration(),
        child: Center(
          child: Text(
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
      height: responsiveSize.scaleSize(250),
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
