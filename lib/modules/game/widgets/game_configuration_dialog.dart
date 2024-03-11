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
    required this.subCategoryId,
    required this.size,
  });

  final GameConfiguration configurations;
  final int subCategoryId;
  final Size size;

  @override
  State<GameConfigurationDialog> createState() =>
      _GameConfigurationDialogState();
}

class _GameConfigurationDialogState extends State<GameConfigurationDialog> {
  final numberOfQuestionsController = TextEditingController();
  late GameConfiguration _configurations;
  late Levels _selectedLevelOfDifficulty;
  late int _selectedNumberOsQuestions;
  late int _subCategoryId;

  @override
  void initState() {
    super.initState();
    _configurations = widget.configurations;
    _selectedNumberOsQuestions = _configurations.totalNumberOfQuestions;
    _subCategoryId = widget.subCategoryId;

    if (_configurations.numberOfOptions == 2) {
      _selectedLevelOfDifficulty = Levels.facil;
    } else if (_configurations.numberOfOptions == 4) {
      _selectedLevelOfDifficulty = Levels.medio;
    } else {
      _selectedLevelOfDifficulty = Levels.dificil;
    }
  }

  @override
  Widget build(BuildContext context) {
    if ([1, 3, 4, 5, 6, 8].contains(_subCategoryId)) {
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
            _buildDifficulty(),
            Divider(
              color: AppColors.darkGray,
              thickness: 2,
            ),
            _buildNumberOfQuestions(),
          ],
        ),
        actions: _buildActions(context),
      );
    } else {
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
        content: _buildNumberOfQuestions(),
        actions: _buildActions(context),
      );
    }
  }

  List<ElevatedTextButton> _buildActions(BuildContext context) {
    return [
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
            _configurations.numberOfOptions = 2;
          } else if (_selectedLevelOfDifficulty == Levels.medio) {
            _configurations.numberOfOptions = 4;
          } else {
            _configurations.numberOfOptions = 6;
          }
          _configurations.totalNumberOfQuestions = _selectedNumberOsQuestions;

          Navigator.pop(context, _configurations);
        },
      ),
    ];
  }

  Column _buildNumberOfQuestions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
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
          min: _configurations.questionsAnswered.toDouble() + 1,
          max: 50,
          onChanged: (value) {
            setState(() {
              _selectedNumberOsQuestions = value.toInt();
            });
          },
        ),
      ],
    );
  }

  Row _buildDifficulty() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Dificuldade:",
          style: TextStyles.textRegular,
        ),
        Padding(
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
        )
      ],
    );
  }
}
