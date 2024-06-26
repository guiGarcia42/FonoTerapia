import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/utils/data.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import '../../../shared/model/game_configuration.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class GameConfigurationDialog extends StatefulWidget {
  const GameConfigurationDialog({
    super.key,
    required this.configurations,
    required this.subCategoryId,
  });

  final GameConfiguration configurations;
  final int subCategoryId;

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
    return AlertDialog(
      backgroundColor: AppColors.orange,
      elevation: 10,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: responsiveSize.scaleSize(20),
      title: MyText(
        "Configurações:",
        style: TextStyles.titleDialog.copyWith(
          fontSize: responsiveSize.scaleSize(TextStyles.titleDialog.fontSize!),
        ),
      ),
      content: [1, 4, 5, 6 ,7, 10].contains(_subCategoryId)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDifficulty(),
                Divider(
                  color: AppColors.darkGray,
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: responsiveSize.scaleSize(10),
                  ),
                  child: _buildNumberOfQuestions(),
                ),
              ],
            )
          : _buildNumberOfQuestions(),
      actions: _buildActions(context),
    );
  }

  List<ElevatedTextButton> _buildActions(BuildContext context) {
    return [
      ElevatedTextButton(
        widthRatio: responsiveSize.scaleSize(125),
        textStyle: TextStyles.buttonTextDialog.copyWith(
          fontSize:
              responsiveSize.scaleSize(TextStyles.buttonTextDialog.fontSize!),
        ),
        text: "Cancelar",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      ElevatedTextButton(
        widthRatio: responsiveSize.scaleSize(125),
        textStyle: TextStyles.buttonTextDialog.copyWith(
          fontSize:
              responsiveSize.scaleSize(TextStyles.buttonTextDialog.fontSize!),
        ),
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
        MyText(
          "Número de Questões:",
          style: TextStyles.textRegular.copyWith(
            fontSize:
                responsiveSize.scaleSize(TextStyles.textRegular.fontSize!),
          ),
        ),
        MyText(
          "$_selectedNumberOsQuestions",
          style: TextStyles.textLargeRegular.copyWith(
            fontSize:
                responsiveSize.scaleSize(TextStyles.textLargeRegular.fontSize!),
          ),
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
        MyText(
          "Dificuldade:",
          style: TextStyles.textRegular.copyWith(
            fontSize:
                responsiveSize.scaleSize(TextStyles.textRegular.fontSize!),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveSize.scaleSize(30),
          ),
          child: DropdownButton(
            value: _selectedLevelOfDifficulty,
            borderRadius: BorderRadius.circular(15),
            iconSize: 40,
            padding: EdgeInsets.only(
              left: responsiveSize.scaleSize(30),
            ),
            items: [
              DropdownMenuItem(
                value: Levels.facil,
                onTap: () {
                  setState(() {
                    _selectedLevelOfDifficulty = Levels.facil;
                  });
                },
                child: MyText(
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
                child: MyText(
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
                child: MyText(
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
