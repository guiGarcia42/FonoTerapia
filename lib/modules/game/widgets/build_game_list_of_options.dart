import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/widgets/icon_button_with_description.dart';

import 'error_text_container.dart';
import 'text_container_button.dart';

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
    if ([1, 3, 4, 6, 10].contains(widget.subCategoryId)) {
      return _buildImageComponent(widget.gameComponents);
    }

    if ([2, 8, 11, 12, 13, 14].contains(widget.subCategoryId)) {
      if ([2, 8].contains(widget.subCategoryId)) {
        return _buildRightOrWrongComponent("Sim", "Não");
      } else {
        return _buildRightOrWrongComponent("Correto", "Incorreto");
      }
    }

    if ([5, 7, 9].contains(widget.subCategoryId)) {
      return _buildTextComponent(widget.gameComponents);
    }

    if ([15, 16, 17].contains(widget.subCategoryId)) {
      return _buildTextInputComponent();
    }

    return ErrorTextContainer();
  }

  GridView _buildImageComponent(List<GameComponent> gameComponents) {
    return GridView.builder(
      itemCount: gameComponents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: responsiveSize.scaleSize(40),
        mainAxisSpacing: responsiveSize.scaleSize(40),
      ),
      itemBuilder: (context, index) {
        final component = gameComponents[index];

        return InkWell(
          onTap: () => widget.onTap(component),
          child: SizedBox(
            height: responsiveSize.scaleSize(250),
            child: Image.asset(
              component.imagePath,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  GridView _buildTextComponent(List<GameComponent> gameComponents) {
    return GridView.builder(
      itemCount: gameComponents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: responsiveSize.scaleSize(40),
        mainAxisSpacing: responsiveSize.scaleSize(40),
      ),
      itemBuilder: (context, index) {
        final component = gameComponents[index];

        return TextContainerButton(
          text: component.name,
          onTap: () => widget.onTap(component),
        );
      },
    );
  }

  Padding _buildRightOrWrongComponent(String right, String wrong) {
    GameComponent? wrongAnswer;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: responsiveSize.scaleSize(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButtonWithDescription(
            icon: Icons.check_circle,
            description: right,
            color: AppColors.right,
            onPressed: () => widget.onTap(widget.rightAnswer),
          ),
          IconButtonWithDescription(
            icon: Icons.cancel,
            description: wrong,
            color: AppColors.wrong,
            onPressed: () => widget.onTap(wrongAnswer),
          ),
        ],
      ),
    );
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
