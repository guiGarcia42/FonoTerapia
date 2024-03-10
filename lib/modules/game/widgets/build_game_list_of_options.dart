import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
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
  final Size size;
  final Function(GameComponent?) onTap;

  const BuildGameListOfOptions(
      {super.key,
      required this.gameComponents,
      required this.subCategoryId,
      required this.rightAnswer,
      required this.size,
      required this.onTap});

  @override
  State<BuildGameListOfOptions> createState() => _BuildGameListOfOptionsState();
}

class _BuildGameListOfOptionsState extends State<BuildGameListOfOptions> {
    TextEditingController textEditingController = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    final aspectRatioFactor = widget.size.width / 400;

    if ([1, 3, 4, 5].contains(widget.subCategoryId)) {
      return _buildImageComponent(widget.gameComponents, aspectRatioFactor);
    }

    if ([2, 7, 9, 10, 11].contains(widget.subCategoryId)) {
      if ([2, 7].contains(widget.subCategoryId)) {
        return _buildRightOrWrongComponent("Sim", "Não");
      } else {
        return _buildRightOrWrongComponent("Correto", "Incorreto");
      }
    }

    if ([6, 8].contains(widget.subCategoryId)) {
      return _buildTextComponent(widget.gameComponents, aspectRatioFactor);
    }

    if ([12, 13, 14].contains(widget.subCategoryId)) {
      return _buildTextInputComponent();
    }

    return ErrorTextContainer(size: widget.size);
  }

  GridView _buildImageComponent(
      // IMAGEM
      List<GameComponent> gameComponents,
      double aspectRatioFactor) {
    return GridView.builder(
      itemCount: gameComponents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.975 * aspectRatioFactor,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        final component = gameComponents[index];

        return Padding(
          padding: EdgeInsets.all(widget.size.height * 0.02),
          child: InkWell(
            onTap: () => widget.onTap(component),
            child: Image.asset(
              component.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  GridView _buildTextComponent(
      // TEXTO
      List<GameComponent> gameComponents,
      double aspectRatioFactor) {
    return GridView.builder(
      itemCount: gameComponents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.975 * aspectRatioFactor,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        final component = gameComponents[index];

        return TextContainerButton(
          size: widget.size,
          text: component.name,
          onTap: () => widget.onTap(component),
        );
      },
    );
  }

  Padding _buildRightOrWrongComponent(String right, String wrong) {
    GameComponent? wrongAnswer;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.size.height * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButtonWithDescription(
            size: widget.size,
            icon: Icons.check_circle,
            description: right,
            color: AppColors.right,
            onPressed: () => widget.onTap(widget.rightAnswer),
          ),
          IconButtonWithDescription(
            size: widget.size,
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
        vertical: widget.size.height * 0.05,
        horizontal: widget.size.width * 0.1,
      ),
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.text,
        maxLines: 1,
        style: TextStyles.textField,
        decoration: InputDecoration(
          hintStyle: TextStyles.textField,
          hintText: 'Digite aqui...',
          filled: true,
          fillColor: AppColors.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
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
