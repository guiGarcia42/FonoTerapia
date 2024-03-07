import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/model/game_component.dart';

class PlayAudioButton extends StatelessWidget {
  const PlayAudioButton({
    super.key,
    required this.size,
    required this.player,
    required this.rightAnswer,
  });

  final Size size;
  final AudioPlayer player;
  final GameComponent rightAnswer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        player.play(AssetSource(rightAnswer.audioPath));
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightOrange,
            border: Border.all(
              color: AppColors.darkGray,
              width: 2,
            )),
        child: Icon(
          Icons.volume_up_rounded,
          size: size.height * 0.2,
          color: AppColors.darkGray,
        ),
      ),
    );
  }
}
