import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';

import 'error_text_container.dart';

class BuildGameQuestion extends StatelessWidget {
  const BuildGameQuestion({
    super.key,
    required this.size,
    required this.player,
    required this.subCategoryId,
    required this.rightAnswer,
  });

  final Size size;
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
    return ErrorTextContainer(size: size);
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
          size: size.height * 0.2,
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
          height: size.height * 0.2,
          decoration: _customBoxDecoration(),
          child: Center(
            child: Text(
              rightAnswer.name,
              style: TextStyles.textLargeRegular,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: size.height * 0.2,
        decoration: _customBoxDecoration(),
        child: Center(
          child: Text(
            rightAnswer.name,
            style: TextStyles.textLargeRegular,
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
      height: size.height * 0.2,
      decoration: _customBoxDecoration(),
      child: ClipOval(
        child: Image.asset(
          rightAnswer.imagePath,
          fit: BoxFit.cover,
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
