import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/modules/startup/loading_view.dart';
import 'package:fono_terapia/modules/game/widgets/tablet_grid_view_component.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/utils/data.dart';
import 'package:fono_terapia/shared/widgets/icon_button_with_description.dart';

import '../../../shared/widgets/error_text_container.dart';
import 'phone_grid_view_component.dart';

class BuildGameListOfOptions extends StatefulWidget {
  final List<GameComponent> gameComponents;
  final int subCategoryId;
  final GameComponent rightAnswer;
  final Function(GameComponent?) onTap;

  const BuildGameListOfOptions(
      {super.key,
      required this.gameComponents,
      required this.subCategoryId,
      required this.rightAnswer,
      required this.onTap});

  @override
  State<BuildGameListOfOptions> createState() => _BuildGameListOfOptionsState();
}

class _BuildGameListOfOptionsState extends State<BuildGameListOfOptions> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if ([1, 3, 4, 5, 6, 7, 9, 10].contains(widget.subCategoryId)) {
      if ([5, 7, 9].contains(widget.subCategoryId)) {
        return _buildGridComponent(widget.gameComponents, false);
      } else {
        return _buildGridComponent(widget.gameComponents, true);
      }
    }

    if ([2, 8, 11, 12, 13, 14].contains(widget.subCategoryId)) {
      return _buildRightOrWrongComponent();
    }

    if ([15, 16, 17].contains(widget.subCategoryId)) {
      return _buildTextInputComponent();
    }

    return ErrorTextContainer();
  }

  Widget _buildGridComponent(List<GameComponent> gameComponents, bool isImage) {
    return responsiveSize.isTablet()
        ? TabletGridViewComponent(
            gameComponents: gameComponents,
            onTap: widget.onTap,
            isImage: isImage,
          )
        : PhoneGridViewComponent(
            gameComponents: gameComponents,
            onTap: widget.onTap,
            isImage: isImage,
          );
  }

  Padding _buildRightOrWrongComponent() {
    GameComponent? wrongAnswer;
    if ([2, 8].contains(widget.subCategoryId)) {
      // 190 é onde inicia as perguntas no array de palavras.
      final isCorrect =
          questionsAnswerList.elementAt(widget.rightAnswer.id - 190);

      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: responsiveSize.scaleSize(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButtonWithDescription(
              icon: Icons.check_circle,
              description: "Sim",
              color: AppColors.right,
              onPressed: () =>
                  widget.onTap(isCorrect ? widget.rightAnswer : wrongAnswer),
            ),
            IconButtonWithDescription(
              icon: Icons.cancel,
              description: "Não",
              color: AppColors.wrong,
              onPressed: () =>
                  widget.onTap(!isCorrect ? widget.rightAnswer : wrongAnswer),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: responsiveSize.scaleSize(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButtonWithDescription(
              icon: Icons.check_circle,
              description: "Correto",
              color: AppColors.right,
              onPressed: () => widget.onTap(widget.rightAnswer),
            ),
            IconButtonWithDescription(
              icon: Icons.cancel,
              description: "Incorreto",
              color: AppColors.wrong,
              onPressed: () => widget.onTap(wrongAnswer),
            ),
          ],
        ),
      );
    }
  }

  Padding _buildTextInputComponent() {
    GameComponent? wrongAnswer;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: responsiveSize.scaleSize(50),
        horizontal: responsiveSize.scaleSize(100),
      ),
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.text,
        maxLines: 1,
        style: TextStyles.textField.copyWith(
          fontSize: responsiveSize.scaleSize(TextStyles.textField.fontSize!),
        ),
        decoration: InputDecoration(
          hintStyle: TextStyles.textField.copyWith(
            fontSize: responsiveSize.scaleSize(TextStyles.textField.fontSize!),
          ),
          hintText: 'Digite aqui...',
          filled: true,
          fillColor: AppColors.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onSubmitted: (value) {
          final normalizedValue = removeDiacritics(value).toLowerCase();
          final normalizedRightAnswer =
              removeDiacritics(widget.rightAnswer.name).toLowerCase();
          if (normalizedValue == normalizedRightAnswer) {
            widget.onTap(widget.rightAnswer);
          } else {
            widget.onTap(wrongAnswer);
          }
          textEditingController.clear();
        },
      ),
    );
  }
}
