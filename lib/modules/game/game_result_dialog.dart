import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_result.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/icon_button_with_description.dart';
import 'package:fono_terapia/shared/widgets/progress_indicator_with_text.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class GameResultDialog extends StatefulWidget {
  const GameResultDialog({
    super.key,
    required this.gameResult,
    required this.subCategory,
  });

  final GameResult gameResult;
  final SubCategory subCategory;

  @override
  State<GameResultDialog> createState() => _GameConfigurationDialogState();
}

class _GameConfigurationDialogState extends State<GameResultDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = (widget.gameResult.answeredCorrectly /
            widget.gameResult.totalQuestions) *
        100;

    final responsiveSize = AppInitializer.responsiveSize;

    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: AppColors.orange,
        elevation: 10,
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actionsOverflowAlignment: OverflowBarAlignment.center,
        actionsOverflowButtonSpacing: responsiveSize.scaleSize(20),
        title: MyText(
          "Resultado",
          style: TextStyles.titleDialog.copyWith(
            fontSize:
                responsiveSize.scaleSize(TextStyles.titleDialog.fontSize!),
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: AppColors.darkGray,
              thickness: 2,
              height: 0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: responsiveSize.height * 0.01,
              ),
              child: MyText(
                "Você acertou ${percentage.toInt()}% de ${widget.gameResult.totalQuestions} exercício(s)!",
                style: TextStyles.textRegular.copyWith(
                  fontSize: responsiveSize
                      .scaleSize(TextStyles.textRegular.fontSize!),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ProgressIndicatorWithText(
              answeredCorrectly: widget.gameResult.answeredCorrectly,
              totalNumberOfQuestions: widget.gameResult.totalQuestions,
            ),
          ],
        ),
        actions: _buildActions(context),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      IconButtonWithDescription(
        icon: Icons.replay_circle_filled_rounded,
        description: "Reiniciar",
        color: AppColors.darkGray,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context)
              .pushReplacementNamed('/game', arguments: widget.subCategory);
        },
      ),
      IconButtonWithDescription(
        icon: Icons.home_rounded,
        description: "Início",
        color: AppColors.darkGray,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
      ),
    ];
  }
}
