import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/utils/data.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import '../../../shared/model/game_configuration.dart';

class GameConfigurationDialog extends StatefulWidget {
  const GameConfigurationDialog({
    super.key,
    required this.configurations,
    required this.size,
  });

  final GameConfiguration configurations;
  final Size size;

  @override
  State<GameConfigurationDialog> createState() =>
      _GameConfigurationDialogState();
}

class _GameConfigurationDialogState extends State<GameConfigurationDialog> {
  final numberOfQuestionsController = TextEditingController();
  late GameConfiguration _configuration;
  late Levels _selectedLevelOfDifficulty;
  late int _selectedNumberOsQuestions;

  @override
  void initState() {
    super.initState();
    _configuration = widget.configurations;
    _selectedNumberOsQuestions = _configuration.numberOfQuestions;

    if (_configuration.numberOfOptions == 2) {
      _selectedLevelOfDifficulty = Levels.facil;
    } else if (_configuration.numberOfOptions == 4) {
      _selectedLevelOfDifficulty = Levels.medio;
    } else {
      _selectedLevelOfDifficulty = Levels.dificil;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.orange,
      elevation: 10,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: widget.size.height * 0.02,
      title: Text(
        "Configurações:",
        style: TextStyles.titleDialog,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNumberOfOptions(),
          Divider(
            color: AppColors.darkGray,
            thickness: 2,
          ),
          _buildNumberOfQuestions(),
        ],
      ),
      actions: [
        ElevatedTextButton(
          widthRatio: widget.size.width * 0.3,
          textStyle: TextStyles.buttonTextDialog,
          text: "Cancelar",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedTextButton(
          widthRatio: widget.size.width * 0.3,
          textStyle: TextStyles.buttonTextDialog,
          text: "Confirmar",
          onPressed: () {
            if (_selectedLevelOfDifficulty == Levels.facil) {
              _configuration.numberOfOptions = 2;
            } else if (_selectedLevelOfDifficulty == Levels.medio) {
              _configuration.numberOfOptions = 4;
            } else {
              _configuration.numberOfOptions = 6;
            }
            _configuration.numberOfQuestions = _selectedNumberOsQuestions;

            Navigator.pop(context, _configuration);
          },
        ),
      ],
    );
  }

  Column _buildNumberOfQuestions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Número de Questões:",
          style: TextStyles.textRegular,
        ),
        Text(
          "$_selectedNumberOsQuestions",
          style: TextStyles.menuOptionDescription,
        ),
        Slider(
          activeColor: AppColors.darkGray,
          value: _selectedNumberOsQuestions.toDouble(),
          min: 2,
          max: 50,
          divisions: 24,
          onChanged: (value) {
            setState(() {
              _selectedNumberOsQuestions = value.toInt();
            });
          },
        ),
      ],
    );
  }

  Row _buildNumberOfOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Número de opções:",
          style: TextStyles.textRegular,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.size.width * 0.03),
            child: DropdownButton(
              value: _selectedLevelOfDifficulty,
              borderRadius: BorderRadius.circular(15),
              iconSize: 40,
              padding: EdgeInsets.only(left: widget.size.width * 0.03),
              items: [
                DropdownMenuItem(
                  value: Levels.facil,
                  onTap: () {
                    setState(() {
                      _selectedLevelOfDifficulty = Levels.facil;
                    });
                  },
                  child: Text(
                    "Fácil",
                    style: TextStyles.textRegular,
                  ),
                ),
                DropdownMenuItem(
                  value: Levels.medio,
                  onTap: () {
                    setState(() {
                      _selectedLevelOfDifficulty = Levels.medio;
                    });
                  },
                  child: Text(
                    "Médio",
                    style: TextStyles.textRegular,
                  ),
                ),
                DropdownMenuItem(
                  value: Levels.dificil,
                  onTap: () {
                    setState(() {
                      _selectedLevelOfDifficulty = Levels.dificil;
                    });
                  },
                  child: Text(
                    "Difícil",
                    style: TextStyles.textRegular,
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  _selectedLevelOfDifficulty = value;
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
