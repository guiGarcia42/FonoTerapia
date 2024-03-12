import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_result.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/icon_button_with_description.dart';
import 'package:fono_terapia/shared/widgets/progress_indicator_with_percentage_text.dart';

class GameResultDialog extends StatefulWidget {
  const GameResultDialog({
    super.key,
    required this.gameResult,
    required this.subCategory,
    required this.size,
  });

  final GameResult gameResult;
  final SubCategory subCategory;
  final Size size;

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

    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: AppColors.orange,
        elevation: 10,
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actionsOverflowAlignment: OverflowBarAlignment.center,
        actionsOverflowButtonSpacing: widget.size.height * 0.02,
        title: Text(
          "Resultado",
          style: TextStyles.titleDialog,
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
                vertical: widget.size.height * 0.01,
              ),
              child: Text(
                "Você acertou ${widget.gameResult.answeredCorrectly} de ${widget.gameResult.totalQuestions}!",
                style: TextStyles.textRegular,
                textAlign: TextAlign.center,
              ),
            ),
            ProgressIndicatorWithPercentageText(percentage: percentage),
          ],
        ),
        actions: _buildActions(context),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      IconButtonWithDescription(
        size: widget.size,
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
        size: widget.size,
        icon: Icons.home_rounded,
        description: "Início",
        color: AppColors.darkGray,
        onPressed: () {
          Navigator.of(context).pop(); // Fecha o diálogo atual
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
      ),
    ];
  }
}
